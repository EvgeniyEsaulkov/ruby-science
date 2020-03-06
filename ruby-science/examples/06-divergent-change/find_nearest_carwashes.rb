class FindNearestCarwashes
  include Interactor

  def call
    washes = Carwash.with_coordinates

    begin
      context.carwashes = washes.select { |cw| haversine_distance(latitude, longitude, cw.lat, cw.lng) < 3000 }
    rescue Errno::ENOENT
      logger.warn('Problem accessing GeoLiteCity.dat')
      context.fail!
    rescue NoMethodError
      context.fail!
    end
  end
end
