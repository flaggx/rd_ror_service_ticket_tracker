class TicketImage < ApplicationRecord
  belongs_to :ticket
  validates :url, presence: true
end