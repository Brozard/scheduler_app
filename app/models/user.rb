class User < ActiveRecord::Base
  has_many :authorizations, dependent: :destroy
  has_many :meetings
  belongs_to :user_timezone
  validates :name, :presence => true

  def self.create_from_hash(hash)
    create(
            name: hash["info"]["name"] || "#{hash["info"]["first_name"]} #{hash["info"]["last_name"]}",
            email: hash["info"]["email"],
            location: hash["info"]["location"]
          )
  end

  def find_auth(provider)
    Authorization.find_by(user_id: id, provider: provider)
  end
end
