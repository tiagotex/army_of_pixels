class HomeController < ApplicationController
  GOOGLE_QR = 'https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=http://armyofpixels.club/session/new?user_token=TOKEN&choe=UTF-8'

  def index
    @color = current_user.color.hex

    unless current_user.token
      current_user.token = Digest::SHA1.hexdigest(Time.now.to_s)
      current_user.save
    end

    @qr_code = GOOGLE_QR.gsub('TOKEN', current_user.token)
    @team_size = Color.find_by(id: current_user.color_id).users_count

    if session[:converting]
      return cancel_convertion if current_user.token == session[:user_token]

      @converting = 'true'
      user = User.find_by(token: session[:user_token])

      return cancel_convertion unless user
      @new_color = user.color.hex

      current_user.color_id = user.color_id
      current_user.save

      clean_session
    end
  end

  private

  def cancel_convertion
    @converting = 'false'
    clean_session
  end

  def clean_session
    session[:converting] = nil
    session[:user_token] = nil
  end
end
