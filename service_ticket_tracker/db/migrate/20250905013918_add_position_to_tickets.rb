class AddPositionToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :position, :integer
    add_index :tickets, [:stage, :position]
  end
end