class StringToInt < ActiveRecord::Migration
  def up
  	change_column :players, :goals, :integer
  	change_column :players, :minutes, :integer
  end

  def down
  	change_column :players, :goals, :string
  	change_column :players, :minutes, :string
  end
end
