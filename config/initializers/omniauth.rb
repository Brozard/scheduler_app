Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['OMNI_SCHEDULE_TWITTER_KEY'], ENV['OMNI_SCHEDULE_TWITTER_SECRET'],
  {
    :secure_image_url => 'true',
    :image_size => 'original',
    :authorize_params => {
      :force_login => 'true',
      :lang => 'pt'
    }
  }
  provider :github, ENV['OMNI_SCHEDULE_GITHUB_KEY'], ENV['OMNI_SCHEDULE_GITHUB_SECRET']
end