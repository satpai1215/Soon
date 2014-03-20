class UpdateTimezoneExistingEvents < ActiveRecord::Migration
  def up
  	CountdownPage.update_all(timezone: "PST")
  end

  def down
	CountdownPage.update_all(timezone: nil)
  end
end
