class Meeting < ActiveRecord::Base
  belongs_to :user

  def starts_at
    start_time.strftime("%l:%M%p")
  end

  def ends_at
    end_time.strftime("%l:%M%p")
  end
end
