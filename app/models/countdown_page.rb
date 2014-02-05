class CountdownPage < ActiveRecord::Base
  	attr_accessible :end_date, :owner, :url_token, :notes, :timepicker, :datepicker, :name
  	attr_accessor :timepicker, :datepicker

  	has_many :persons, dependent: :destroy
  	accepts_nested_attributes_for :persons

	after_create :generate_url_token, only: [:create]
	validates_uniqueness_of :url_token

	validates :name, :datepicker, :timepicker, :presence => true
  	validates_format_of :datepicker, with: /^\d{2}[\/-]\d{2}[\/-]\d{4}/
  	validates_format_of :timepicker, with: /^\d{1,2}:\d{2}[ap]m/i

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

end
