# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/new' do
  @song = Song.new
  erb :new
end

post '/' do
  @song = Song.new(name: params[:name], author: params[:author], url: params[:url])
  if @song.save
    redirect '/'
  else
    erb :new
  end
end
