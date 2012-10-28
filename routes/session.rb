class Moola < Sinatra::Application
  get '/session/new' do
    erb 'sessions/new'.to_sym
  end

  post '/session/create' do
    username = params[:username]
    password = params[:password]

    user = User.authenticate(username,password)
    if user
      session[:user_id] = user.id
      redirect '/home/dashboard'
    else
      redirect '/session/new'
    end
  end

  get '/session/destroy' do
    session.clear
    redirect '/'
  end
end
