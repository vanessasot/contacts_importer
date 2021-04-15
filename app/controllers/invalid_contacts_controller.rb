class InvalidContactsController < ApplicationController
  before_action :set_invalid_contact, only: %i[ show update destroy ]
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @invalid_contacts = current_user.invalid_contacts.paginate(page: params[:page], per_page: 5)
    end
  end

  def destroy
    @invalid_contact.destroy
    respond_to do |format|
      format.html { redirect_to invalid_contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_invalid_contact
      @invalid_contact = InvalidContact.find(params[:id])
    end

    def invalid_contact_params
      params.require(:invalid_contact).permit(:user_id, :name, :telephone, :email, :address, :birthday, :credit_card_number, :credit_card_franchise, :credit_card_last_four_digits, :error_message)
    end
end
