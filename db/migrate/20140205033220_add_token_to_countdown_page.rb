class AddTokenToCountdownPage < ActiveRecord::Migration
  def change
  	add_column :countdown_pages, :url_token, :string
  	add_column :countdown_pages, :notes, :text
  end
end
