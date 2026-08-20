require "test_helper"

class GoalTest < ActiveSupport::TestCase
  test "is valid with a title" do
    goal = Goal.new(title: "Learn Rails")
    assert goal.valid?
  end

  test "is invalid without a title" do
    goal = Goal.new(title: nil)
    assert_not goal.valid?
    assert_includes goal.errors[:title], "can't be blank"
  end

  test "defaults to not completed" do
    goal = Goal.create!(title: "Meditate daily")
    assert_not goal.completed?
  end

  test "toggle_completed! flips the completed flag" do
    goal = Goal.create!(title: "Drink more water", completed: false)
    goal.toggle_completed!
    assert goal.reload.completed?
    goal.toggle_completed!
    assert_not goal.reload.completed?
  end

  test "active and done scopes partition goals" do
    active = Goal.create!(title: "Active goal", completed: false)
    done = Goal.create!(title: "Done goal", completed: true)
    assert_includes Goal.active, active
    assert_includes Goal.done, done
    assert_not_includes Goal.active, done
  end
end
