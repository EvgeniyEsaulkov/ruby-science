class FacebookUser
  def initialize(params)
    @id = params[:id]
  end

  attr_reader :id

  def profile_image_url
    "https://graph.facebook.com/#{id}/picture?type=square"
  end
end
