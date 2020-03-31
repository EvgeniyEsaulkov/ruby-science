class UtilsController < ApplicationController
   # GET /
  def index
    user_lat, user_lng = determine_user_coords
    result = FindNearestCarwashes.call(latitude: user_lat, longitude: user_lng)
    if result.success?
      @carwashes = result.carwashes
    else
      redirect_to root_path, alert: result.error
    end
  end

  # GET /nearest_carwashes
  def nearest_carwashes
    result = FindNearestCarwashes.call(latitude: params[:lat].to_f, longitude: params[:lng].to_f)

    if result.success?
      @carwashes = result.carwashes

      render carwashes_view, layout: false
    else
      redirect_to root_path, alert: result.error
    end
  end

  private

  def carwashes_view
    if params[:map]
      "utils/_onmap_carwashes"
    else
      "_carwashes"
    end
  end
end
