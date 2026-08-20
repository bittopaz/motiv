class GoalsController < ApplicationController
  before_action :set_goal, only: %i[ show edit update destroy toggle ]

  # GET /goals or /goals.json
  def index
    @goals = Goal.order(completed: :asc, created_at: :desc)
  end

  # GET /goals/1 or /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals or /goals.json
  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: "Goal was successfully created." }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @goal.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /goals/1 or /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: "Goal was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @goal.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /goals/1 or /goals/1.json
  def destroy
    @goal.destroy!

    respond_to do |format|
      format.html { redirect_to goals_path, notice: "Goal was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # PATCH /goals/1/toggle
  def toggle
    @goal.toggle_completed!
    redirect_to goals_path, notice: "Goal marked as #{@goal.completed? ? 'completed' : 'active'}."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def goal_params
      params.expect(goal: [ :title, :motivation, :completed ])
    end
end
