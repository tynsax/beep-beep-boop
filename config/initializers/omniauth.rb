Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret
  provider :google_oauth2, Rails.application.secrets.google_provider_key, Rails.application.secrets.google_provider_secret,
    {
      name: 'google',
      scope: 'email, profile, calendar.readonly',
      image_size: 256,
      image_aspect_ratio: 'square'
    }
end
