class CountdownPagesController < ApplicationController


  # GET /countdown_pages/1
  # GET /countdown_pages/1.json
  def show
    @countdown_page = CountdownPage.decrypt(params[:url_token])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /countdown_pages/new
  # GET /countdown_pages/new.json
  def new
    @countdown_page = CountdownPage.new
    2.times {@countdown_page.persons.build}
  end

  # GET /countdown_pages/1/edit
  def edit
    @countdown_page = CountdownPage.decrypt(params[:url_token])
    if @countdown_page
      @countdown_page.datepicker = @countdown_page.end_date.strftime("%m/%d/%Y")
      @countdown_page.timepicker = @countdown_page.end_date.strftime("%I:%M%p")
    else
      redirect_to root_path, notice: "event could not be found"
    end
  end

  # POST /countdown_pages
  # POST /countdown_pages.json
  def create
    @countdown_page = CountdownPage.new(params[:countdown_page])

    respond_to do |format|
      if @countdown_page.save
        format.html { redirect_to countdown_path(@countdown_page), notice: 'Countdown page was successfully created.' }
      else
        format.html { render action: "new", notice: "Countdown could not be created." }
      end
    end
  end

  # PUT /countdown_pages/1
  # PUT /countdown_pages/1.json
  def update
    #_form submit routes to /countdown_pages/:id, with the :id being the url_token
    @countdown_page = CountdownPage.decrypt(params[:id])

    respond_to do |format|
      if @countdown_page.update_attributes(params[:countdown_page])
        format.html { redirect_to countdown_path(@countdown_page), notice: 'Countdown was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /countdown_pages/1
  # DELETE /countdown_pages/1.json
  def destroy
    @countdown_page = CountdownPage.find(params[:id])
    @countdown_page.destroy

    respond_to do |format|
      format.html { redirect_to countdown_pages_url }
    end
  end
end
