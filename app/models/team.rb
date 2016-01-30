class Team < ActiveRecord::Base
  belongs_to :tournament

  before_validation { self.shortname ||= self.school }

  validates :school, presence: true
  validates :mascot, presence: true
  validates :shortname, presence: true
  validates :mascot, presence: true
  validates :region_id, presence: true,
    numericality: { greater_than_or_equal_to: 0, less_than: 4 }
  validates :tournament, presence: true
end
