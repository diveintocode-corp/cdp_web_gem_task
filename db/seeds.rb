status=["todo","doing","done"]
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end
50.times do |n|
  Task.create!(title:"タスク#{n+1}",description:"タスク#{n+1}の内容",status:status.sample,deadline:time_rand(Time.local(2010, 1, 1)))
end
