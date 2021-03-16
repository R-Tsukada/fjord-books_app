# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'github')
    else
      request.env['omniauth.auth']
      redirect_to new_user_registrarion_url
    end
  end

  def failure
    redirect_to root_path
  end
end
