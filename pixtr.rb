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
  @galleries = Gallery.order("name ASC")
  erb :index
end

get "/galleries/new" do
  erb :new_gallery
end

get "/galleries/:id" do
  @id = params[:id]
  @gallery = Gallery.find(@id)
  @images = @gallery.images
  erb :gallery
end

post "/galleries" do
  @gallery = Gallery.create(params[:gallery])
  redirect to("/galleries/#{@gallery.id}")
end
