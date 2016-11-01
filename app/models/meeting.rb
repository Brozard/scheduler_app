class Meeting < ActiveRecord::Base
  belongs_to :user

  def starts_at
    start_time.strftime("%l:%M%p")
  end

  def start_datetime
    start_time.strftime("%B %-d %Y, %l:%M%p %Z")
  end

  def ends_at
    end_time.strftime("%l:%M%p")
  end

  def end_datetime
    end_time.strftime("%B %-d %Y, %l:%M%p %Z")
  end

  scope :upcoming, -> { where("start_time > ?", Time.current) }
end
