# db/migrate/XXXXXXXXXXXXXX_create_tickets.rb
class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string  :account_name,        null: false
      t.string  :city,                null: false
      t.string  :contact_person
      t.string  :contact_info
      t.enum    :priority, enum_type: :priority, default: "low", null: false
      t.enum    :work_type, enum_type: :work_type, null: true
      t.boolean :lease,               default: false, null: false
      t.boolean :under_warranty,      default: false, null: false
      t.string  :machine_model_or_type
      t.text    :issue_description
      t.string  :requesting_tech_name
      t.integer :assigned_to, index: true  # will add FK below

      t.timestamps
    end

    add_foreign_key :tickets, :users, column: :assigned_to
  end
end
