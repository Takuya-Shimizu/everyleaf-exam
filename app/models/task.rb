class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    belongs_to :user
    has_many :labelings, dependent: :destroy
    has_many :labels, through: :labelings

    scope :deadline, -> {order(deadline_at: :desc)}
    scope :search_title, ->(title){where("title LIKE ?", "%#{title}%")}
    scope :search_status, ->(status){where(status: status)}
    scope :search_label, ->(label){where(id: Labeling.where(label_id: label).select(:task_id))}
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