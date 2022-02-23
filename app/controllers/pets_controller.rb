class PetsController < ApplicationController

    def index
        # get data on all pets and paginate the output to 10 per page
        @active_pets = Pet.active.alphabetical.paginate(page: params[:page]).per_page(10)
        @inactive_pets = Pet.inactive.alphabetical.to_a
    end

end
