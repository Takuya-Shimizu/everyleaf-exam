FactoryBot.define do
  factory :labeling do
    association :task_second
    association :label
  end
end
