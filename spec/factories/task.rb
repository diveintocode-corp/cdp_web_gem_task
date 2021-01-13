FactoryBot.define do
  factory :task1, class: Task  do
    title { 'タスク1' }
    description { 'タスクの内容1' }
    status { 'todo' }
    deadline { '2020-01-01' }
  end
  factory :task2, class: Task  do
    title { 'タスク2' }
    description { 'タスクの内容2' }
    status { 'doing' }
    deadline { '2021-01-01' }
  end
  factory :task3, class: Task  do
    title { 'タスク3' }
    description { 'タスクの内容3' }
    status { 'done' }
    deadline { '2023-01-01' }
  end
  factory :task4, class: Task  do
    title { 'タスク4' }
    description { 'タスクの内容4' }
    status { 'todo' }
    deadline { '2024-01-01' }
  end
  factory :task5, class: Task  do
    title { 'タスク5' }
    description { 'タスクの内容5' }
    status { 'doing' }
    deadline { '2025-01-01' }
  end
end
