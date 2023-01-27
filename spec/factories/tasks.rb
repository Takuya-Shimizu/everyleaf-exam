FactoryBot.define do
  factory :task do
    title { 'test_title_1' }
    content { 'test_content' }
    deadline { '002023-12-31' }
    status { 'working' }
    priority { '低' }
  end

  factory :task_first, class: Task do
    title { '2' }
    content { '2' }
    deadline { '002023-11-30' }
    status { 'waiting' }
    priority { '中' }
  end

end