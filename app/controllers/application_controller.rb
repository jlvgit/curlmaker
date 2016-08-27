class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :curl

private

  def curl
    @curls   = Curl.all
    @sidenav = @curls.map(&:service).compact.uniq.sort
  end
end
