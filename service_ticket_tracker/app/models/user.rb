class User < ApplicationRecord
  has_secure_password

  has_many :assigned_tickets,
           class_name: "Ticket",
           foreign_key: :assigned_to,
           inverse_of: :assigned,
           dependent: :nullify

  validates :username, presence: true, uniqueness: true
end