# A simple todo item for a task

class Todo < ActiveRecord::Base
  belongs_to :company
  belongs_to :task
  belongs_to :completed_by_user, :class_name => "User", :foreign_key => "completed_by_user_id"


  acts_as_list :scope => 'task_id = #{task_id} AND completed_at IS NULL'

  def done?
    self.completed_at != nil
  end

  def done
    self.done?
  end

  def css_classes
    self.done? ? "todo todo-completed" : "todo todo-active"
  end
end


# == Schema Information
#
# Table name: todos
#
#  id                   :integer(4)      not null, primary key
#  task_id              :integer(4)
#  name                 :string(255)
#  position             :integer(4)
#  creator_id           :integer(4)
#  completed_at         :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  completed_by_user_id :integer(4)
#
# Indexes
#
#  index_todos_on_task_id  (task_id)
#

