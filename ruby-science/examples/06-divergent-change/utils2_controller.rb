class UtilsController < ApplicationController
   # GET /
  def index
    user_lat, user_lng = determine_user_coords
    fetch_carwashes(user_lat, user_lng)
  end

  # GET /nearest_carwashes
  def nearest_carwashes
    lat, lng = params[:lat].to_f, params[:lng].to_f
    fetch_carwashes(lat, lng)

    if params[:map]
      render "utils/_onmap_carwashes", layout: false
    else
      render "_carwashes", layout: false
    end
  end

  private

  def fetch_carwashes(latitude, longitude)
    result = FindNearestCarwashes.call(latitude: latitude, longitude: longitude)
    @carwashes = result.success? ? result.carwashes : []
  end
end
