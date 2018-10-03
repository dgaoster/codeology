class AvailabilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_login
  before_action :logged_in_user, only: [:new, :create, :index]
  before_action :correct_user,   only: [:destroy]

  def showUserAvailability
    @curr_user = User.find(session[:user_id])
    @userAvailabilitys = @curr_user.availabilitys.order('time ASC')
    render layout: 'web_application'
  end
  
  def prune
    @curr_user = User.find(session[:user_id])
    Availability.where("time <= ?", 24.hours.from_now).destroy_all
    redirect_to availabilities_path
  end

  def index
    # Not the most efficient way to do this
    # Every time a user looks at availabilities, all availabilities
    # within 24 hours are deleted (so that people can only sign up for
    # an interview at least 24 hours in advance)
    #
    # Potential optimization is to keep a boolean that tracks if this
    # has been done within the past hour interval. This will reduce amount
    # of times we hit the database.
    #
    # However, due to the small scale of this application this is fine
    # If for some reason this application needs to scale then the
    # optimization is recommended.
    Availability.where("time <= ?", 24.hours.from_now).destroy_all

    @curr_user = User.find(session[:user_id])
    @allAvailabilitys = Availability.where.not(user_id: session[:user_id]).order('time ASC')
    render layout: 'web_application'
  end

  def new
    @curr_user = User.find(session[:user_id])
    render layout: 'web_application'
  end
 
  def create
    date = params[:availability][:date]
    time = params[:availability][:time]
    # combine date and time
    datetime = Date.new(date).to_datetime + time.seconds_since_midnight.seconds
    # convert to UTC
    datetime = datetime.gmtime

    @availability = Availability.new(time: datetime, user_id: User.find(session[:user_id]))
    if @availability.save
      flash.now[:info] = "Availability saved."
    else
      flash.now[:danger] = "Availability couldn't be saved."      
    end 
    render :new  
  end
 
  def destroy
    Availability.find(params[:id]).destroy
    flash.now[:success] = "Availability deleted"
    redirect_to showUserAvailability_path
  end

  # the update path is used exclusively for booking interviews
  def update
    @curr_user = User.find(session[:user_id])    
    @availability = Availability.find(params[:id])
    @upcoming_interview = Upcoming_interview.new(interviewee: @curr_user.id, interviewer: @availability.user_id, time: @availability.time)
    if @upcoming_interview.save
      flash.now[:success] = "Successful booking!"
      Availability.find(params[:id]).destroy
    else
      flash.now[:danger] = "Booking failed. Submit an issue if this persists"
    end
    redirect_to availabilities_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def availability_params
      params.require(:availability).permit(
        :time
      )
    end

    def redirect_to_login
      redirect_to login_path
    end
      
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless user_is_logged_in?
        flash[:warning] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user or user is admin
    def correct_user
      @user = User.find(@availability.user_id)
      unless (current_user?(@user) || is_admin?)
        flash[:warning] = "You do not have authorization."        
        redirect_to dashboard_path 
      end
    end
end