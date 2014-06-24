require "sinatra"

GALLERIES = {
  "dogs" => ["shibe.png"],
  "cats" => ["grumpy_cat.png", "colonel_meow.jpg"]
}

get "/" do
  @page_title = "Pixtr Galleries"
  erb :index, layout: :layout
end

get "/gallery/:name" do
  @name = params[:name]
  @page_title = "#{@name.capitalize} Gallery"
  erb :gallery, layout: :layout
end
