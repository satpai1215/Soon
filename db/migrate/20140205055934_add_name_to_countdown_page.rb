class AddNameToCountdownPage < ActiveRecord::Migration
  def change
  	add_column :countdown_pages, :name, :string
  end
end
