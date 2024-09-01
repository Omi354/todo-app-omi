class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :username)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :avatar, :username)
  end
end
