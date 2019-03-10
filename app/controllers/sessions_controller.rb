class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': code }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    binding.pry
    redirect_to root_path
  end

  def logout
    session.delete :token
    redirect_to root_path
  end
end
