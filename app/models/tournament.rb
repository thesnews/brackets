class Tournament < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :brackets, dependent: :destroy

  validates :name, presence: true
  validates :event, presence: true
  validates :start_date, presence: true

  def year
    start_date.year
  end
  
end
