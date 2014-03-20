class AddTimezoneToCountdownpages < ActiveRecord::Migration
  def change
  	add_column :countdown_pages, :timezone, :string
  end
end
