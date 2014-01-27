class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    auth = request.env["omniauth.auth"]
    @user = User.find_by_provider_and_uid(auth.provider, auth.uid) || User.create_with_omniauth(auth)

    Rails.logger.info (">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> auth.provider = #{auth.provider}")
    Rails.logger.info (">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> auth.uid = #{auth.uid}")
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      session[:user_id] = @user.id
    else
      session[:user_id] = @user.id
      redirect_to new_user_registration_url
    end
  end
end