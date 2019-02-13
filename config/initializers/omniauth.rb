Rails.application.config.middleware.use OmniAuth::Builder do
  provider :microsoft_office365, ENV["MICROSOFT_CLIENT_ID"], ENV["MICROSOFT_CLIENT_SECRET"], {hd: 'barracuda.com' }
end
