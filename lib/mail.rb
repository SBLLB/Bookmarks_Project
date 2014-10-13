require 'rest_client'

module Mail

	  def send_simple_message(user)
      RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
      "@api.mailgun.net/v2/samples.mailgun.org/messages",
      :from => "rachel@thedairygirl.com",
      :to => user.email,
      :subject => "DB test",
      :text => "Reset your password by visiting this link: http://localhost:9292/reset_password/#{user.password_token}"
    end

end