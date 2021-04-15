class ImportFilesController < ApplicationController
    before_action :authenticate_user!

    def index
      @import_files = ImportFile.all
    end
  
    def new
      @import_file = ImportFile.new
    end
  
    def import
      @imported_files = current_user.import_files.build(filename: params[:file].original_filename)
      if @imported_files.save
        @imported_files.import(params[:file], current_user)
        redirect_to contacts_path, notice: "Contacts imported successfully!"
      end
    end
end
