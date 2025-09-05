class Ticket < ApplicationRecord
  belongs_to :assigned, class_name: "User", foreign_key: :assigned_to, optional: true
  has_many :images, class_name: "TicketImage", dependent: :destroy, inverse_of: :ticket
  has_many :ticket_updates, -> { order(created_at: :asc) }, dependent: :destroy

  enum :priority, { low: "low", medium: "medium", high: "high" }, prefix: true
  enum :work_type, { install: "install", removal: "removal" }, prefix: true, allow_nil: true

  enum :stage, {
    not_scheduled:      "not_scheduled",
    install_removal:    "install_removal",
    scheduled_today:    "scheduled_today",
    scheduled_tomorrow: "scheduled_tomorrow",
    parts_needed:       "parts_needed",
    parts_ready:        "parts_ready",
    repair_complete:    "repair_complete"
  }, prefix: true

  # Auto-place tickets in the Install / Removal column when created
  before_validation :default_stage_from_work_type, on: :create

  # Keep completed_at in sync with stage
  before_save :set_completed_timestamp

  private

  def default_stage_from_work_type
    # Only auto-set when the currently computed stage is nil or at the default not_scheduled,
    # and work_type is install/removal.
    return unless work_type.in?(%w[install removal])
    if stage.nil? || stage == "not_scheduled"
      self.stage = "install_removal"
    end
  end

  def set_completed_timestamp
    if will_save_change_to_stage?
      if stage == "repair_complete" && completed_at.nil?
        self.completed_at = Time.current
      elsif stage != "repair_complete"
        # Remove this line if you want to preserve completion time after first completion
        self.completed_at = nil
      end
    end
  end
end