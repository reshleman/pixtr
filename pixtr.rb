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

# GET index
get "/" do
  @galleries = Gallery.order("name ASC")
  erb :index
end

# GET gallery instance
get "/galleries/:gallery_id" do
  @gallery = Gallery.find(params[:gallery_id])
  @images = @gallery.images
  erb :gallery
end

# GET new gallery form
get "/galleries/new" do
  erb :new_gallery
end

# POST new gallery
post "/galleries" do
  @gallery = Gallery.create(params[:gallery])
  redirect to("/galleries/#{@gallery.id}")
end

# GET edit gallery form
get "/galleries/:gallery_id/edit" do
  @gallery = Gallery.find(params[:gallery_id])
  erb :edit_gallery
end

# PUT edited gallery
put "/galleries/:gallery_id" do
  @gallery = Gallery.find(params[:gallery_id])
  @gallery.update(params[:gallery])
  redirect to("/galleries/#{@gallery.id}")
end

# DELETE gallery
delete "/galleries/:gallery_id" do
  @gallery = Gallery.find(params[:gallery_id])

  @gallery.images.each do |image|
    image.destroy
  end

  @gallery.destroy
  redirect to("/")
end

# GET new image form
get "/galleries/:gallery_id/images/new" do
  @gallery_id = params[:gallery_id]
  erb :new_image
end

# POST new image
post "/galleries/:gallery_id/images" do
  @image = Image.create(params[:image])
  redirect to("/galleries/#{@image.gallery_id}")
end
