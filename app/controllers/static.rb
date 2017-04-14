get '/' do
  @url = Url.last 
  erb :"static/index"
   # let user create new short URL, display a list of shortened URLs THAT YOU HAVE SUBMITTED
end

post '/urls' do    # create a new Url # i.e. /q6bda
  #params #<== a hash that you pass from your form to the controller action	
  print params
 
  @url = Url.new(long_url:params[:long_url], click_count: 0)
  if @url.save
    return @url.to_json
  else
    status 404
  	return @url.errors.full_messages
  end 
end


get '/:short_url' do   # redirect to appropriate "long" URL
  @url = Url.where(short_url:params[:short_url]).first
  @url.click_count += 1
  @url.save
  redirect "#{@url.long_url}"
end

 # bundle exec shotgun config.ru to run

# post '/urls' do    # create a new Url # i.e. /q6bda
#   #params #<== a hash that you pass from your form to the controller action 
#   print params
 
#   @url = Url.new(long_url:params[:long_url], click_count: 0)
#   if @url.save 
#     redirect '/'
#   else
#     @error = @url.errors.full_messages.first
#     erb :"static/index" 
#   end 
# end