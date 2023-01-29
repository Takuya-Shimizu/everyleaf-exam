FactoryBot.define do
  factory :labelings do
    asociation { :task_second }
    asociation { :label }
  end
end
