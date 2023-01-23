FactoryBot.define do
  factory :task do
    title { 'test_title_1' }
    content { 'test_content' }
    deadline { '002023-12-31' }
    status { 'working' }
    priority { '低' }
  end
end