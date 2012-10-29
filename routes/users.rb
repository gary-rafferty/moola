class Moola < Sinatra::Application
  get '/users/new' do
    erb 'users/new'.to_sym
  end

  post '/users/create' do
    username = params[:username]
    password = params[:password]
    if valid_credentials username,password
      user = User.create(username: username, password: password)
      if user
        id = User.find_by_username(username).id
        session[:user_id] = id
        redirect 'home/dashboard'
      else
        flash[:notice] = 'Error creating user'
        redirect 'users/new'
      end
    else
      flash[:notice] = 'Problem with username/password'
      redirect 'users/new'
    end
  end
end
