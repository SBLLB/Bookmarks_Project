require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'mailgun'

require './lib/link'
require './lib/tag'
require './lib/user'
require './lib/mail'


require_relative 'helpers/application'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
 
 include Mail

	set :views, Proc.new {File.join(root, "..", "views")}
  enable :sessions
  set :session_secret, 'super secret'

  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do 
  	url = params["url"]
  	title = params["title"]
  	tags = params["tags"].split(" ").map do |tag|
  		Tag.first_or_create(:text => tag)
  	end
  	Link.create(:url => url, :title => title, :tags => tags)
  	redirect to('/')
  end

  get '/tags/:text' do 
  	tag = Tag.first(:text => params[:text])
  	@links = tag ? tag.links : []
  	erb :index
  end

  get '/users/new' do 
    @user=User.new
    erb :users_new
  end

  post '/users' do
    @user = User.create(:email => params[:email],
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :users_new
    end
  end

  get '/sessions/new' do 
    erb :sessions_new
  end

  post '/sessions' do

    email, password = params[:email], params[:password]  
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :sessions_new
    end
  end 

  delete '/sessions' do
    flash[:notice] = "Goodbye!"
    session[:user_id] = nil
    redirect to('/')
  end

  post '/reset_password' do 
    erb :reset_password
  end 
 
  post '/reset_password2' do 
    user = User.first(:email => params[:email])
    if user 
      user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
      user.password_token_timestamp = Time.now
      send_simple_message(user)
      user.save
      "Check your emails"
    else
      "You entered an invalid email - create flash error"
      erb :reset_password2
    end
  end
 
 # get '/reset_password/:token' do 


 #    erb :create_new_password
 #  end  

 #  post '/reset_password/confirma'

  

  # start the server if ruby file executed directly
  run! if app_file == $0
end
