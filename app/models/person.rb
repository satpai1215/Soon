class Person < ActiveRecord::Base
  attr_accessible :email, :gender, :name
  attr_accessor :index

  belongs_to :countdown_page

  validates :name, :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
