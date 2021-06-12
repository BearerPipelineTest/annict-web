# frozen_string_literal: true

class SignInController < ApplicationV6Controller
  layout "v6/simple"

  before_action :redirect_if_signed_in

  def new
    if params[:back]
      store_location_for(:user, params[:back])
    end

    # From OAuth client
    if params[:client_id]
      @oauth_app = Doorkeeper::Application.available.find_by(uid: params[:client_id])
    end

    @form = ::Forms::SignInForm.new
    @recaptcha = Recaptcha.new(action: "sign_in")
  end
end
