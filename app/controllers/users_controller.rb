class UsersController < ApplicationController
  OAUTH_CONSUMER = OAuth::Consumer.new(ENV['TRELLO_API_KEY'], ENV['TRELLO_SECRET'],
                                        {
                                          site: "https://trello.com/",
                                          access_token_url: "https://trello.com/1/OAuthGetAccessToken",
                                          authorize_url: "https://trello.com/1/OAuthAuthorizeToken",
                                          request_token_url: "https://trello.com/1/OAuthGetRequestToken"
                                        }
                                      )

  before_action :check_trello_token, only: :boards

  def connect_trello_account
    trello_url_to_get_token = request_token.authorize_url
    ap trello_url_to_get_token
    redirect_to trello_url_to_get_token
  end

  def connect_trello_account_callback

    oauth_verifier = params[:oauth_verifier]
    res = request_token.get_access_token(oauth_verifier: oauth_verifier)
    current_user.update(token: res.token, secret: res.secret)
    redirect_to users_boards_path
  end


def boards
  url = URI("https://api.trello.com/1/members/me/boards?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  response = https.request(request)
  @data = JSON.parse(response.read_body)
end



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
    params.require(:user).permit(:token, :secret)
  end

  def request_token
    OAUTH_CONSUMER.get_request_token(oauth_callback: users_connect_trello_account_callback_url)
  end

  def check_trello_token
    redirect_to users_connect_trello_account_path if current_user.token.nil?
  end
end
