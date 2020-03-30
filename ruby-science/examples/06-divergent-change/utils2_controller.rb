class UtilsController < ApplicationController
   # GET /
  def index
    user_lat, user_lng = determine_user_coords
    @carwashes = FindNearestCarwashes.call(latitude: user_lat, longitude: user_lng)
  end

  # GET /nearest_carwashes
  def nearest_carwashes
    @carwashes = FindNearestCarwashes.call(latitude: params[:lat].to_f, longitude: params[:lng].to_f)

    if params[:map]
      render "utils/_onmap_carwashes", layout: false
    else
      render "_carwashes", layout: false
    end
  end
end
