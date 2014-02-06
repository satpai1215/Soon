class ChangeGenderToIsMale < ActiveRecord::Migration
  def up
  	remove_column :users, :gender
  	add_column :users, :is_male, :boolean, default: false
  end

  def down
  	remove_column :users, :is_male
  	add_column :users, :gender, :boolean, default: true
  end
end
