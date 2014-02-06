class AddDjidToCountdownPages < ActiveRecord::Migration
  def change
  	add_column :countdown_pages, :finish_job_id, :integer
  end
end
