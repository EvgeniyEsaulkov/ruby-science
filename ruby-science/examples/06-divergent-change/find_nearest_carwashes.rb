class FindNearestCarwashes
  include Interactor

  MAX_DISTANCE = 3000

  def call
    begin
      context.carwashes = nearest_washes
    rescue Errno::ENOENT => e
      logger.warn('Problem accessing GeoLiteCity.dat')
      context.fail!(error: e.inspect)
    rescue NoMethodError => e
      context.fail!(error: e.inspect)
    end
  end

  private

  def nearest_washes
    washes.select { |cw| haversine_distance(latitude, longitude, cw.lat, cw.lng) < MAX_DISTANCE }
  end

  def washes
    Carwash.with_coordinates
  end
end
