class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # GET/activities
    def index
        render json: Activity.all, status: :ok
    end

    # DELETE/activities/:id [Need to delete associated signups]
    def destroy

        activity = Activity.find(params[:id])
        activity.signups.destroy_all
        activity.destroy
        head :no_content
    end

    private
    
    def record_not_found(error)
        render json: {error: "#{error.model} not found"}, status: :not_found
    end
end
