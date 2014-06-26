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

post "/galleries" do
  @gallery = Gallery.create(params[:gallery])
  redirect to("/galleries/#{@gallery.id}")
end

get "/galleries/:id" do
  @id = params[:id]
  @gallery = Gallery.find(@id)
  @images = @gallery.images
  erb :gallery
end

get "/galleries/:gallery_id/edit" do
  @gallery = Gallery.find(params[:gallery_id])
  erb :edit_gallery
end

put "/galleries/:gallery_id" do
  @gallery = Gallery.update(params[:gallery_id], params[:gallery])
  redirect to("/galleries/#{@gallery.id}")
end

get "/galleries/:gallery_id/images/new" do
  @gallery_id = params[:gallery_id]
  erb :new_image
end

post "/galleries/:gallery_id/images" do
  @image = Image.create(params[:image])
  redirect to("/galleries/#{@image.gallery_id}")
end
