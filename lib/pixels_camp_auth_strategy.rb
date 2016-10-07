require 'net/http'
class PixelsCampAuthStrategy < ::Warden::Strategies::Base
  def authenticate!
    uri = URI.parse('https://api.pixels.camp/user/auth')
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = params['token']

    result = Net::HTTP.start(uri.hostname, 80) do |http|
      http.request(request)
    end

    return fail! message: "strategies.password.failed" unless result.code == 200

    body = JSON.parse(result.body)

    user = User.find_by(username: body['login'])

    if user.present?
      success! user
    else
      fail! message: "strategies.password.failed"
    end
  end
end

Warden::Strategies.add(:pixel_camp_auth, PixelsCampStrategy)
