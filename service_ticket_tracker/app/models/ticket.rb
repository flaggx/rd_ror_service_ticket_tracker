class Ticket < ApplicationRecord
  # ... existing code ...
  belongs_to :assigned, class_name: "User", foreign_key: :assigned_to, optional: true
  has_many :images, class_name: "TicketImage", dependent: :destroy, inverse_of: :ticket
  has_many :ticket_updates, -> { order(created_at: :asc) }, dependent: :destroy


  enum :priority, { low: "low", medium: "medium", high: "high" }, prefix: true
  enum :work_type, { install: "install", removal: "removal" }, prefix: true, allow_nil: true
  # ... existing code ...

  enum :stage, {
    not_scheduled:      "not_scheduled",
    install_removal:    "install_removal",
    scheduled_today:    "scheduled_today",
    scheduled_tomorrow: "scheduled_tomorrow",
    parts_needed:       "parts_needed",
    parts_ready:        "parts_ready",
    repair_complete:    "repair_complete"
  }, prefix: true

  before_save :set_completed_timestamp

  private

  def set_completed_timestamp
    if will_save_change_to_stage?
      if stage == "repair_complete" && completed_at.nil?
        self.completed_at = Time.current
      elsif stage != "repair_complete"
        # If you want to preserve completion time, delete the next line
        self.completed_at = nil
      end
    end
  end
end