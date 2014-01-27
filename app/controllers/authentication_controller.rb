class AuthenticationController < ApplicationController

  def authenticate
    @user = current_user
      
    respond_to do |format|
      format.json { render json: @user }
    end
  end
end