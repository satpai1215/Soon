class CountdownPage < ActiveRecord::Base
  	attr_accessible :end_date, :owner, :url_token, :notes, :timepicker, :datepicker, :name, :users_attributes, :finished_job_id
  	attr_accessor :timepicker, :datepicker

  	has_many :users, dependent: :destroy
  	accepts_nested_attributes_for :users

	after_create :generate_url_token, only: [:create]
	validates_uniqueness_of :url_token, :finished_job_id

	validates :name, :datepicker, :timepicker, :presence => true
  	validates_format_of :datepicker, with: /^\d{2}[\/-]\d{2}[\/-]\d{4}/
  	validates_format_of :timepicker, with: /^\d{1,2}:\d{2}[ap]m/i

  	before_save :build_end_date_and_validate, :on => [:create, :update]

	def to_param
		#self.url_token
		CountdownPage.encrypt(self.id)
	end

	def self.decrypt(token)
		begin
			hashids = Hashids.new("this is my salt", 25)
			id = hashids.decrypt(token)
		rescue NoMethodError
			return nil
		else
			return id.empty? ? nil : CountdownPage.find_by_id(id)
		end
	end

	def self.encrypt(id)
		hashids = Hashids.new("this is my salt", 25)
		hashids.encrypt(id)
	end



	private

	#creates unique token to append to url (for restricted access)
	def generate_url_token
		#self.url_token = SecureRandom.hex(8)
		hashids = Hashids.new("this is my salt", 25)
		#  self.url_token = 
		self.update_column(:url_token, hashids.encrypt(self.id))
  	end


	def build_end_date_and_validate
		begin
		  @date = Date.strptime(@datepicker, '%m/%d/%Y')
		  @time = Time.parse(@timepicker)
		rescue ArgumentError
		  errors.add(:end_date, "date is not a valid date or format (must be a valid date with mm/dd/yyyy hh:mm ampm)" )
		  return false
		else
		  #converts to datetime in PDT for easier date subtraction
		  self.end_date = DateTime.parse("#{@date} #{@time}")
		  end_date_valid?
		end
	end

	def end_date_valid?
		if self.end_date.past?
		  errors.add(:end_date, "happens in the past!" )
		  return false
		end
	end

end
