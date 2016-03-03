class Tournament < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :brackets, dependent: :destroy

  validates :name, presence: true
  validates :event, presence: true
  validates :start_date, presence: true

  validates :region0, presence: true
  validates :region1, presence: true
  validates :region2, presence: true
  validates :region3, presence: true

  def year
    start_date.year
  end

  def full_name
    "#{name} #{event} #{year}"
  end

  def started?
    DateTime.now > start_date
  end
  
end
