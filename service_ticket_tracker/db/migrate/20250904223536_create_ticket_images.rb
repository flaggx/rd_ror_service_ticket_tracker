class CreateTicketImages < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_images do |t|
      t.string :url
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
