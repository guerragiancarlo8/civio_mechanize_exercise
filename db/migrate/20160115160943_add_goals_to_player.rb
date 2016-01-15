class AddGoalsToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :goals, :string
  end
end
