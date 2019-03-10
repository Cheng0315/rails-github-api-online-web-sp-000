class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    binding.pry
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': code, 'redirect_uri': 'http://localhost:3000/auth' }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end

  def logout
    session.delete :token
    redirect_to root_path
  end
end
