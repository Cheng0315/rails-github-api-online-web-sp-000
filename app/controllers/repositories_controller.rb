class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get("https://github.com/login/oauth/authorize") do |req|
      req.params['oauth_token'] = session[:token]
    end
  end

end
