
require "sinatra"
require "sinatra/activerecord"

class User < ActiveRecord::Base
end

helpers do
  # helper for link_to,  
  def link_to(url,text=url,opts={})
    attributes = ""
	opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
	"<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  def delete_user_button(user_id)
    erb :_delete_user_button, locals: { user_id: user_id}
  end
end

get '/' do
  @users = User.all
  erb :'users/index'
end

get '/new' do
  @user = User.new
  erb :'users/new'
end

post '/user' do
  User.create(:name => params[:name], :email => params[:email], :desc => params[:desc])
  @users = User.all
  erb :'users/index'
end

delete "/user/:id" do
  @user = User.find(params[:id]).destroy
  redirect "/"
end

 
