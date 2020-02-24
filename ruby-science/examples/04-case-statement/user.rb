class User
  MAPPING = { 2: FacebookUser, 3: AppUser }

  def self.find(params)
    MAPPING.fetch(params[:logged], UnknownUser).new(params)
  end
end
