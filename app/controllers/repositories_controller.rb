class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = "appication/json"
    end
    @user_info = JSON.parse(resp.body)

    repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = "appication/json"
    end
    @repos = JSON.parse(repo_resp.body)
  end

end
