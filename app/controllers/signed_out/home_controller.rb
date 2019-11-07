module SignedOut

  class HomeController < SignedOutUserController
    def index
      #puts Category.all
    end
  end

end