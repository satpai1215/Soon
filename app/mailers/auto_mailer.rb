class AutoMailer < ActionMailer::Base

  def countdown_finish_email(page_id)
	@page = CountdownPage.find(page_id)
    mail(:bcc => email_list(page_id), :subject => "Congratulations!  Your Countdown Has Expired.")
  end

  def email_list(page_id)
  	@page = CountdownPage.find(page_id)

  	if @page
  		@page.users.maps {|user| user.email}
  	else
  		[]
  	end
  end

end