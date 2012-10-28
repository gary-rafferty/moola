class Moola < Sinatra::Application
  get '/' do
    erb 'home/index'.to_sym
  end

  get '/home/dashboard' do
    erb 'home/dashboard'.to_sym
  end
end
