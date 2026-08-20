class Goal < ApplicationRecord
  validates :title, presence: true

  scope :active, -> { where(completed: false) }
  scope :done, -> { where(completed: true) }

  def toggle_completed!
    update!(completed: !completed)
  end
end
