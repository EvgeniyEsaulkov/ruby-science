class SessionsControler < ApplicationController
  def create
    # ...
    update_device_information(user, params[:device_token])
    # ...
  end

  private

  def update_device_information(user, device_token)
    return unless device_token

    device = Device.find_or_initialize_by_token(device_token)
    device.update_information(user)
  end
end
