class GoalsController < ApplicationController
    before_action :find_goal, only:[:show, :edit, :update, :destroy]
    
    def index
        if user_signed_in?
			# Selects the items where the user's id is the same as the current_user.
			# Selects only the checklist items for the current_user.
			@goals = Goal.where(:user_id => current_user.id).order("created_at DESC")
		end	
    end
    def show
    end
    
    def new
        @goal  = current_user.goals.build
        
    end
    
    def create
        @goal = current_user.goals.build(goal_params)
        if @goal.save
            redirect_to root_path
        end
    end
    
    
    def edit
    end
    def update
        if @goal.update(goal_params)
            redirect_to goal_path(@goal)
        else
            render 'edit'
        end
    end
    def destroy
        @goal.destroy
        redirect_to root_path
    end
    
    def complete
        
        @goal = Goal.find(params[:id])
        @goal.update_attribute(:completed_at, Time.now)
        redirect_to root_path
    end
    
    private 
    
    def goal_params
        params.require(:goal).permit(:title, :description)
    end
        
    def find_goal
        @goal = Goal.find(params[:id])
    end
end
