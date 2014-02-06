class CountdownOverJob < Struct.new(:page_id)

	def perform
		if(CountdownPage.exists?(page_id))
			@page = Event.find(page_id)

    		AutoMailer.countdown_finish_email_(page_id).deliver
    		
    	end
	end

end