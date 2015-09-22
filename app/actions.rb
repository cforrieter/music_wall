# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/new' do
  @song = Song.new
  erb :new
end

get '/users/login' do 
  erb :'users/login'
end

get '/users/new' do 
  erb :'users/new'
end

get '/users/logout' do 
  session.clear
  redirect '/'
end

post '/song/create' do
  @song = Song.new(name: params[:name], author: params[:author], url: params[:url])
  if @song.save
    redirect '/'
  else
    erb :new
  end
end

post '/users/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    session[:user] = @user
    redirect '/'
  else
    redirect '/users/login'
  end
end

post '/users/create' do
  if params[:password] == params[:confirm_password]
    session[:user] = User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect '/'
  else
    redirect '/users/new'
  end
end

get '/users/upvote/:id' do
  @voted = Vote.where("user_id = ? AND song_id = ?", session[:user].id, params[:id]).first
  unless @voted
    session[:user].votes.create(song_id: params[:id], upvote: true)
  else
    if @voted.upvote == true
      @voted.upvote = false
    else
      @voted.upvote = true
    end
    @voted.save
  end

  redirect '/'
end