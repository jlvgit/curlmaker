class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :curl

private

  def curl
    @curls = Curl.all
    @services = {
      :Otto    => ["Accounts", "Authentication", "Users", "Groups"],
      :Sawdust => ["Accounts", "Attributes", "Contexts", "Documents",
                              "Legal Hold", "Search"],
      :Filbert => ["Jobs"]
    }
  end
end
