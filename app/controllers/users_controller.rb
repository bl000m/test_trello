require 'uri'
require 'awesome_print'
require 'trello'
require "cgi"
require 'oauth'
require "net/http"

class UsersController < ApplicationController
  # https://trello.com/1/authorize?return_url=http://toto.com&callback=fragment&scope=read&expiration=never&name=test&key=75b1c40455bee39212ffc46c1ba5be7c&response_type=token



  TOKEN = nil
  # callback_url = "https://.../callback"

  def connect_trello_account

    redirect request_token.authorize_url
    oauth_consumer = OAuth::Consumer.new(ENV[TRELLO_API_KEY],
                                         ENV[TRELLO_SECRET],
                                          {
                                            site: "https://trello.com/",
                                            access_token_url: "https://trello.com/1/OAuthGetAccessToken",
                                            authorize_url: "https://trello.com/1/OAuthAuthorizeToken",
                                            request_token_url: "https://trello.com/1/OAuthGetRequestToken"
                                          }
                                        )

    request_token = oauth_consumer.get_request_token(oauth_callback: callback_url)
  end

  def connect_trello_account_callback

    oauth_verifier = params[:oauth_verifier]
    res = request_token.get_access_token(current_user: oauth_verifier)

    TOKEN = res.token
    SECRET = res.secret

    if TOKEN.nil?
      redirect '/connect'
  end


def get_boards
  url = URI("https://api.trello.com/1/members/me/boards?key=#{ENV[TRELLO_API_KEY]}&token=#{ENV[TRELLO_SECRET]}")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  response = https.request(request)
  JSON.parse(response.read_body)
end





# get '/connect' do
#   redirect request_token.authorize_url
# end

# get '/boards' do
#   if TOKEN.nil?
#     redirect '/connect'
#     return
#   end

#   @boards = get_boards
#   erb :boards
# end


#     - strore token and secret in current_user model



  private

  def contact_params
    params.require(:user).permit(:email)
  end

end
