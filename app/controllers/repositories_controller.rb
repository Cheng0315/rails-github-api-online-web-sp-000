class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = "appication/json"
    end
    binding.pry
    @repo = JSON.parse(resp.body)
  end

end
