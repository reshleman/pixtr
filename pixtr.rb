require "sinatra"
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "pixtr"
)

class Gallery < ActiveRecord::Base
  has_many :images
end

class Image < ActiveRecord::Base
end

get "/" do
  @page_title = "Pixtr Galleries"
  @galleries = Gallery.order("name ASC")
  erb :index
end

get "/galleries/new" do
  @page_title = "Create a New Gallery"
  erb :new_gallery
end

get "/gallery/:name" do
  @name = params[:name]
  @gallery = Gallery.find_by(name: @name)
  @images = @gallery.images
  @page_title = "#{@gallery.name.capitalize} Gallery"
  erb :gallery
end

post "/galleries" do
  @gallery = Gallery.new(params[:gallery])
  @gallery.save
  redirect to("/gallery/#{@gallery.name}")
end
