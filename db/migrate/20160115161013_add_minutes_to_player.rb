class AddMinutesToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :minutes, :string
  end
end
