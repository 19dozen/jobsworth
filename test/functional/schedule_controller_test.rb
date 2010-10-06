require "test_helper"


class ScheduleControllerTest < ActionController::TestCase
  fixtures :users, :companies, :tasks

  def setup
    login
  end

  test "/gantt should display and assign some tasks" do
    get :gantt
    assert_response :success

    tasks = assigns['tasks']
    assert_not_nil tasks
    assert tasks.length > 0
  end

  test "/gantt should update due_at" do
    task = tasks(:one_day_duration_task)
    user = users(:admin)

    get :gantt_save, :id => task.task_num, :duration => 1, :due_date => "10/11/2010"
    due_date = TZInfo::Timezone.get(user.time_zone).local_to_utc(DateTime.strptime("10/11/2010", user.date_format).to_time)
    assert_equal due_date, Task.find(tasks(:one_day_duration_task).id).due_at
    assert_response :success
  end

  test "/gantt should update duration" do
    task = tasks(:one_day_duration_task)

    get :gantt_save, :id => task.task_num, :duration => 2, :due_date => "7/11/2010"
    assert_equal 960, Task.find(tasks(:one_day_duration_task).id).duration
    assert_response :success
  end
  
end
