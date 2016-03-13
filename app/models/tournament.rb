class Tournament < ActiveRecord::Base
  SLUG_PATTERN = %r([a-z_\-\d]+-\d{4})
  extend FriendlyId

  friendly_id :name_and_event, use: [:slugged]

  has_many :teams, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :brackets, dependent: :destroy

  scope :live, -> { where(live: true) }

  validates :name, presence: true
  validates :event, presence: true
  validates :start_date, presence: true

  validates :region0, presence: true
  validates :region1, presence: true
  validates :region2, presence: true
  validates :region3, presence: true

  # TODO: Switch to Postgres array type on switch to Rails 4
  # This is an array of hashes, with the shape:
  # {
  #   id: <bracket id>,
  #   position: <description of person>,
  #   headshot: <photo headshot id>
  # }
  serialize :featured, JSON

  def year
    start_date.year
  end

  def full_name
    "#{name} #{event} #{year}"
  end

  def started?
    DateTime.now > start_date
  end

  def normalize_friendly_id(s)
    "#{super}-#{year}"
  end

  def should_generate_new_friendly_id?
    name_changed? or event_changed? or start_date_changed? or super
  end

  def top_brackets(limit)
    brackets = self.brackets.includes(:user).order('score DESC').limit(limit)

    rank = 1
    ranks = brackets.each_with_index.map do |bracket, i|
      if i > 0 && bracket.score < brackets[i - 1].score
        rank = i + 1
      end
      rank
    end
    brackets.zip(ranks, fetch_champions(brackets))
  end

  def update_brackets!
    self.brackets
    .includes(tournament: { games: [:team1, :team2] })
    .find_each do |bracket|
      bracket.calculate_score
      bracket.save!
    end
  end

  private
  def name_and_event
    "#{name} #{event}"
  end

  def fetch_champions(brackets)
    ids = brackets.map { |bracket| bracket.picks[62] }.compact
    teams = Tournament::Team.where(id: ids)
    teams = teams.map { |team| [team.id, team] }
    teams = Hash[teams]
    brackets.map { |bracket| teams[bracket.picks[62]] }
  end
end
