class BottlesController < ApplicationController

    before do
        authentication_required
    end

    get '/bottles' do
        @bottles = Bottle.where(user_id: current_user.id)
        erb :'/bottles/index'
    end

    get '/bottles/new' do
        erb :'bottles/new'
    end

    post '/bottles' do
       @bottles = Bottle.create
       @bottles.name = params[:name]
       @bottles.spirit = params[:spirit]
       @bottles.abv = params[:abv]
       @bottles.origin = params[:origin]
       @bottles.price = params[:price]
       @bottles.user = current_user

       if @bottles.save
        redirect '/bottles'
       else
        flash[:notice] = " Save did not work "
        erb :"bottles/new"
       end
    end

    get '/bottles/:id' do
        @bottle = Bottle.find(params[:id])
        if @bottle.user_id != current_user.id
            flash[:notice] = " You can't view that bottle "
            redirect "/bottles"
        end
        erb :'/bottles/show'
    end

    get '/bottles/:id/edit' do
        @bottle = Bottle.find(params[:id])
        if @bottle.user_id != current_user.id
            flash[:notice] = " You can't edit that bottle "
            redirect "/bottles"
        end
        erb :'/bottles/edit'
    end

    patch '/bottles/:id' do
        @bottle = Bottle.find(params[:id])
        if @bottle.user_id != current_user.id
            error do
                "You can't delete this bottle"
            end
            redirect "/bottles"
        end
        form_values = params.reject {|k,v| ['_method', 'id'].include?(k.to_s)}
        @bottle.update(form_values)
        redirect "/bottles/#{params[:id]}"
    end

    delete '/bottles/:id' do
        @bottle = Bottle.find(params[:id])
        if @bottle.user_id != current_user.id
            error do
                "You can't delete this user's bottle"
            end
            redirect "/bottles"
        end
        @bottle.destroy
        redirect "/bottles"
        end
end