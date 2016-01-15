class AddGoalsMinToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :goalsmin, :float
  end
end
