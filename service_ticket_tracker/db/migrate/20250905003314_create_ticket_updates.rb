class CreateTicketUpdates < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_updates do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :user_name
      t.text :content, null: false
      t.timestamps
    end

    add_index :ticket_updates, :created_at
  end
end