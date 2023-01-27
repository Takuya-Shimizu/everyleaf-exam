class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    belongs_to :user

    scope :deadline, -> {order(deadline_at: :desc)}
    scope :search_title, ->(title){where("title LIKE ?", "%#{title}%")}
    scope :search_status, ->(status){where(status: status)}
    enum status: {
      waiting: 0,
      working: 1,
      done: 2
    }
    enum priority: {
      高: 0,
      中: 1,
      低: 2
    }
end