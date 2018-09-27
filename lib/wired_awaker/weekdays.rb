class WiredAwaker::WeekDays
  attr_accessor :title, :story_body, :url, :day_stories
  @@all = []

  def initialize
    @day_stories = []
    @@all << self

  end

  def self.stories=(stories)
    @day_stories << stories
  end

  def self.stories
    @day_stories
  end

  def self.all
    @@all
  end


end
