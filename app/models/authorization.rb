class Authorization < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, :presence => true
  validates :uid, uniqueness: { scope: :provider }

  def self.find_or_create_from_hash(hash)
    unless auth = find_by(provider: hash['provider'], uid: hash['uid'])
      auth = create(provider: hash['provider'], uid: hash['uid'], nickname: hash['info']['nickname'], username: (hash['info']['username'] || hash["info"]["email"].rpartition("@")[0]))
    end
   
    auth
  end
end
