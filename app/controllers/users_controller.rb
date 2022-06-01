require 'uri'
require 'awesome_print'
require 'trello'
require "cgi"
require 'oauth'
require "net/http"

class UsersController < ApplicationController

  def connect_trello_account
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

  end

# https://trello.com/1/authorize?return_url=http://toto.com&callback=fragment&scope=read&expiration=never&name=test&key=75b1c40455bee39212ffc46c1ba5be7c&response_type=token



# TOKEN = nil
# callback_url = "https://.../callback"



# def get_boards
#   url = URI("https://api.trello.com/1/members/me/boards?key=#{API_KEY}&token=#{TOKEN}")

#   https = Net::HTTP.new(url.host, url.port)
#   https.use_ssl = true

#   request = Net::HTTP::Get.new(url)
#   response = https.request(request)
#   JSON.parse(response.read_body)
# end



# get '/' do
#   erb :index
# end

# get '/callback' do
#   oauth_verifier = params[:oauth_verifier]
#   res = request_token.get_access_token(oauth_verifier: oauth_verifier)

#   TOKEN = res.token
#   SECRET = res.secret
# end

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


# def create
#   @contact = Contact.new(contact_params)
#   if @contact.save
#     redirect_to root_path
#     Trello.configure do |config|
#       config.developer_public_key = ENV['TRELLO_PUBLIC_KEY']
#       config.member_token = ENV['TRELLO_MEMBER_TOKEN']
#     end
#     me = Trello::Member.find("mathia_pagani")

#     # find first board
#     board = me.boards.first
#     puts board.name
#     # puts "Lists: #{board.lists.map {|x| x.name}.join(', ')}"
#     # puts "Members: #{board.members.map {|x| x.full_name}.join(', ')}"
#     board.cards.each do |card|
#           puts "fu"
#           # puts "-- Actions: #{card.actions.nil? ? 0 : card.actions.count}"
#           # puts "-- Members: #{card.members.count}"
#           # puts "-- Labels: #{card.labels.count}"
#     end
#   else
#     render 'new'
#   end

  private

  def contact_params
    params.require(:mail).permit(:create)
  end

end
