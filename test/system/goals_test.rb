require "application_system_test_case"

class GoalsTest < ApplicationSystemTestCase
  test "listing existing goals" do
    visit goals_path

    assert_text "Run a 5k"
    assert_text "Read 12 books this year"
  end

  test "creating a goal" do
    visit goals_path
    click_on "+ New goal"

    fill_in "Title", with: "Learn to swim"
    fill_in "Why it matters", with: "Face my fear of water"
    click_on "Create Goal"

    assert_text "Goal was successfully created."
    assert_text "Learn to swim"
  end

  test "marking a goal as completed" do
    goal = goals(:one)
    visit goals_path

    within "#goal_#{goal.id}" do
      find("button.goal-check").click
    end

    assert_text "Goal marked as completed."
  end
end
