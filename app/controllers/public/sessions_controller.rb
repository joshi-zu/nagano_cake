# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_end_customer, only: [:create]

  protected

  def reject_end_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をお願いします"
        redirect_to new_customer_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] ="該当ユーザーが見つかりません"
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
