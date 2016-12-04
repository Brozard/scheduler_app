class Meeting < ActiveRecord::Base
  belongs_to :user
  validate :end_after_start
  validates :start_time, :end_time, :presence => true

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

  private

    def end_after_start
      return if end_time.blank? || start_time.blank?
     
      if end_time < start_time
        errors.add(:end_time, "must be after the start date") 
      end 
    end
end
