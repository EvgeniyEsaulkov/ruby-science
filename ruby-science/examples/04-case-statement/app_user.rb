class AppUser
  def initialize(params)
    @photo_url = params[:photo_url]
  end

  attr_reader :photo_url
  alias :profile_image_url :photo_url
end
