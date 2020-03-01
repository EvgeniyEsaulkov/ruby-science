class ClientsController
   def create
    @client = @carwash.clients.new(client_params)
    set_bonus_and_state

    if @client.save
      redirect_to @client, notice: 'Клиент успешно добавлен'
    else
      render action: 'new'
    end
  end

  def update
    set_bonus_and_state

    if @client.update_attributes(client_params)
      redirect_to @client, notice: 'Данные клиента сохранены'
    else
      render action: 'edit'
    end
  end

  private

  def set_bonus_and_state
    return unless CarwashPolicy.new(current_user, @carwash).manage?

    @client.set_bonus_and_state(params[:client])
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

class Client < ApplicationRecord
  def set_bonus_and_state(params)
    self.bonus = params[:bonus] if params[:bonus].present?
    self.status = params[:status]
  end
end
