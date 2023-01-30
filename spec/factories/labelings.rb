FactoryBot.define do
  factory :labelings do
    association { :task_second }
    association { :label }
  end
end
