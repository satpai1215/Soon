class AutoMailer < ActionMailer::Base

  default from: "Soon... <notifications@soon.com>"

  def countdown_created_email(page_id)
    @page = CountdownPage.find(page_id)
    @owner = @page.users.first.name
    @url = countdown_url(@page)
    mail(:to => email_list(page_id), :subject => "A Countdown has been created for you!")
  end

  def countdown_finish_email(page_id)
    @page = CountdownPage.find(page_id)
    mail(:to => email_list(page_id), :subject => "Congratulations!  Your Countdown Has Expired.")
  end

  def email_list(page_id)
  	@page = CountdownPage.find(page_id)

  	if @page
  		@page.users.map {|user| user.email}
  	else
  		[]
  	end
  end

end