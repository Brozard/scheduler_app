Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['OMNI_SCHEDULE_TWITTER_KEY'], ENV['OMNI_SCHEDULE_TWITTER_SECRET'],
  {
    :secure_image_url => 'true',
    :image_size => 'original',
    :authorize_params => {
      # :force_login => 'true',
      :lang => 'en'
    }
  }
  provider :github, ENV['OMNI_SCHEDULE_GITHUB_KEY'], ENV['OMNI_SCHEDULE_GITHUB_SECRET']
  provider :facebook, ENV['OMNI_SCHEDULE_FACEBOOK_KEY'], ENV['OMNI_SCHEDULE_FACEBOOK_SECRET'],
    client_options: {
      site: 'https://graph.facebook.com/v2.7',
      authorize_url: "https://www.facebook.com/v2.7/dialog/oauth"
    }
end