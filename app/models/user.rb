class User < ActiveRecord::Base
  has_many :authorizations, dependent: :destroy
  has_many :meetings
  validates :name, :presence => true

  def self.create_from_hash(hash)
    create(
            name: hash["info"]["name"] || "#{hash["info"]["first_name"]} #{hash["info"]["last_name"]}",
            email: hash["info"]["email"],
            location: hash["info"]["location"] || hash["extra"]["raw_info"]["location"]["name"],
            nickname: hash["info"]["nickname"] || hash["extra"]["raw_info"]["username"]
          )
  end

  def find_auth(provider)
    Authorization.find_by(user_id: id, provider: provider)
  end

  def check_nickname
    if nickname == nil || nickname == 'meetings'
      random_nickname
    else
      nickname
    end
  end

  private
    def random_nickname
      nickname = Faker::Lorem.word
      if User.find_by(nickname: nickname)
        nickname = nil
        random_nickname
      else
        nickname
      end
    end
end
