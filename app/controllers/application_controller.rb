# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後の遷移
  def after_sign_in_path_for(_resource)
    books_path
  end

  # ログアウト後の遷移
  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password postal_code address description password_confirmation remember_me]
    # サインアップ時にemailのストロングパラメータを追加
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
