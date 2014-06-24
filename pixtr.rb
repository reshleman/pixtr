require "sinatra"

GALLERIES = {
  "dogs" => ["shibe.png"],
  "cats" => ["grumpy_cat.png", "colonel_meow.jpg"]
}

get "/gallery/:name" do
  @name = params[:name]
  erb :gallery, layout: :gallery_layout
end
