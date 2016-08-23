class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :curl

private

  def curl
    @curls = Curl.all
    @services = @curls.map(&:service).compact.uniq
  end
end
