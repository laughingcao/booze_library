class ApplicationController < Sinatra::Base
  use Rack::Flash
  use Rack::MethodOverride

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_protection"
  end

  get "/" do
    @user = current_user if logged_in?
    erb :welcome
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
      end
    end

    def authentication_required
      if !logged_in?
        flash[:notice] = " You must be logged in."
        redirect '/'
      end
    end

end
