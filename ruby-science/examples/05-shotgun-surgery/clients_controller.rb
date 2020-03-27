class ClientsController
   def create
    @client = @carwash.clients.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Клиент успешно добавлен'
    else
      render action: 'new'
    end
  end

  def update
    if @client.update_attributes(client_params)
      redirect_to @client, notice: 'Данные клиента сохранены'
    else
      render action: 'edit'
    end
  end

  private

  def client_params
    client_params = params.require(:client).permit(:name, :email)

    if CarwashPolicy.new(current_user, @carwash).manage?
      client_params.merge!(special_client_params)
    end

    client_params
  end

  def special_client_params
    params.require(:client).permit(:bonus, :status)
  end
end

class CarwashPolicy
  attr_reader :user, :carwash

  def initialize(user, carwash)
    @user = user
    @carwash = carwash
  end

  def manage?
    user.is_owner_of?(carwash) || user.is_manager?
  end
end
