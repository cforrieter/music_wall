# Homepage (Root path)
get '/' do
  @songs = Song.all.order(score: :desc)
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

get '/songs/show/:id' do
  @song = Song.find(params[:id])
  erb :'/songs/show'
end

post '/song/create' do
  @song = Song.new(name: params[:name], author: params[:author], url: params[:url], user_id: session[:user])
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
end

post '/songs/show/:id/review/create' do
  @voted = Vote.where("user_id = ? AND song_id = ?", session[:user].id, params[:id]).first
  unless @voted
    session[:user].votes.create(song_id: params[:id], review: params[:review], review_rating: params[:review_rating])
  else
    @voted.review = params[:review]
    @voted.review_rating = params[:review_rating].to_i
    @voted.save
  end

  redirect "/songs/show/#{params[:id]}"
end

get '/songs/show/:id/review/delete' do
  @voted = Vote.find_by(user_id: session[:user].id, song_id: params[:id])
  if @voted
    @voted.review = nil
    @voted.review_rating = nil  
    @voted.save
  end
  redirect "/songs/show/#{params[:id]}"
end