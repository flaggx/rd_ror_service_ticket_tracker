class AddScheduledDateToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :scheduled_date, :date
  end
end
