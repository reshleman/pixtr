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
  erb :index, layout: :layout
end

get "/gallery/:name" do
  @name = params[:name]
  @gallery = Gallery.find_by(name: @name)
  @images = @gallery.images
  @page_title = "#{@gallery.name.capitalize} Gallery"
  erb :gallery, layout: :layout
end
