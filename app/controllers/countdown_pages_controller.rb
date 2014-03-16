class CountdownPagesController < ApplicationController

  def home
  end

  # GET /:url_token
  def show
    @countdown_page = CountdownPage.decrypt(params[:url_token])
    @user1 = @countdown_page.users.first
    @user2 = @countdown_page.users.last
    
    if @countdown_page.nil?
      redirect_to root_path, notice: "The countdown you requested could not be found."
    else
      @is_finished = @countdown_page.end_date.past?
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end

  # GET /new
  def new
    @countdown_page = CountdownPage.new
    @url = countdowns_path
    @method = :post
    2.times {|n| @countdown_page.users.build.index = n}
  end

  # POST /
  def create
    @countdown_page = CountdownPage.new(params[:countdown_page])

    respond_to do |format|
      if @countdown_page.save
        write_jobs(@countdown_page.id)

        AutoMailer.countdown_created_email(@countdown_page.id).deliver

        format.html { redirect_to countdown_path(@countdown_page), notice: 'Countdown was successfully created.' }
      else
        @url = countdowns_path
        @method = :post
        format.html { render action: "new", notice: "Countdown could not be created." }
      end
    end
  end

  # GET /:url_token/edit
  def edit
    @countdown_page = CountdownPage.decrypt(params[:url_token])
    @url = countdown_path(@countdown_page)
    @method = :put
    if @countdown_page
      @countdown_page.datepicker = @countdown_page.end_date.strftime("%m/%d/%Y")
      @countdown_page.timepicker = @countdown_page.end_date.strftime("%I:%M%p")
    else
      redirect_to root_path, notice: "event could not be found"
    end
  end

  # PUT /:url_token
  def update
    #_form submit routes to /countdown_pages/:id, with the :id being the url_token
    @countdown_page = CountdownPage.decrypt(params[:url_token])

    respond_to do |format|
      if @countdown_page.update_attributes(params[:countdown_page])
        write_jobs(@countdown_page.id)
        format.html { redirect_to countdown_path(@countdown_page), notice: 'Countdown was successfully updated.' }
      else
        @url = countdown_path(@countdown_page)
        @method = :patch
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /:url_token
  def destroy
    @countdown_page = CountdownPage.decrypt(params[:id])
    destroy_jobs(@countdown_page.id)
    @countdown_page.destroy

    respond_to do |format|
      format.html { redirect_to countdown_pages_url }
    end
  end


  private

  def write_jobs(page_id)
    @page = CountdownPage.find(page_id)

    #delete delayed_jobs if it exists
    destroy_jobs(page_id)

    #rewrite delayed_jobs for updated page
    page_job = Delayed::Job.enqueue(CountdownOverJob.new(page_id), 0, @page.end_date)

    # save id of delayed job on CountdownPage record
    @page.update_column(:finish_job_id, page_job.id)

  end

  def destroy_jobs(page_id)
    @page = CountdownPage.find(page_id)

    #if record has :finish_job_id and the DJ record exists, destroy it
    if @page.finish_job_id and Delayed::Job.exists?(@page.finish_job_id)
      Delayed::Job.find(@page.finish_job_id).destroy
    end
  end

end
