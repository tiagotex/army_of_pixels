class HomeController < ApplicationController
  GOOGLE_QR = 'https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=http://armyofpixels.club/session/new?user_token=TOKEN&choe=UTF-8'

  def index
    # current_user.color
    @color = '#fdcf1a'
    @old_color = '#ff3300'

    @qr_code = GOOGLE_QR.gsub('TOKEN', current_user.token)

    @token = current_user.token

    if session[:converting]
      return clean_session if current_user.token == session[:user_token]

      @converting = true
      @old_color = current_user.color.hex
      @color = User.find_by(token: session[:user_token]).color.hex

      current_user.color_id = User.find_by(token: session[:user_token]).color_id
      current_user.save

      clean_session
    end
  end

  private

  def clean_session
    session[:converting] = nil
    session[:user_token] = nil
  end
end
