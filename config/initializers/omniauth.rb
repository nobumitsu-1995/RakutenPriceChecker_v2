Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_API_ID'], ENV['GOOGLE_API_SECRET'], callback_url: "http://localhost:3000/auth/google_oauth2/callback"
end
