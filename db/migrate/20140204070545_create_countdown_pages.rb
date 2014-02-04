class CreateCountdownPages < ActiveRecord::Migration
  def change
    create_table :countdown_pages do |t|
      t.datetime :end_date
      t.string :owner

      t.timestamps
    end
  end
end
