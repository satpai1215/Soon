class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.boolean :gender, default: true
      t.references :countdown_pages

      t.timestamps
    end
  end
end
