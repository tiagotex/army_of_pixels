require 'net/http'
Warden::Strategies.add(:pixels_camp_auth) do
  def valid?
     true
  end

  def authenticate!
    uri = URI.parse('https://api.pixels.camp/user/auth')
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = params['token']

    result = Net::HTTP.start(uri.hostname, 80) do |http|
      http.request(request)
    end

    return fail! message: "strategies.password.failed" unless result.code == '200'

    body = JSON.parse(result.body)

    user = User.find_by(username: body['login'])
    user.token = Digest::SHA1.hexdigest(Time.now.to_s)
    user.save

    if user.present?
      success! user
    else
      fail! message: "strategies.password.failed"
    end
  end
end
