class InvalidContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @invalid_contacts = current_user.invalid_contacts.paginate(page: params[:page], per_page: 5)
    end
  end
end
