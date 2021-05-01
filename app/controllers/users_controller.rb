class UsersController < ApplicationController

    get '/register' do
        erb :'users/new'
    end

    post '/register' do
        if User.find_by(email: params[:email]) != nil
            flash[:notice] = " That email has already been used "
            redirect '/'
        end
       @user = User.create
       @user.email = params[:email]
       @user.password = params[:password]

       if @user.save
            user = User.find_by(:email => params[:email])
            user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/login"
       else
            erb :'users/new'
       end
    end

    get '/login' do
        erb :'users/login'
    end 

    post '/login' do
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
            session["user_id"] = @user.id
            redirect "/bottles"
        else
            flash[:notice] = "Make sure your password and email are correct"
            redirect "/login"
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end