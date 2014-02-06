class ChangePeopleTableToUsers < ActiveRecord::Migration
    def change
        rename_table :people, :users
    end 
end
