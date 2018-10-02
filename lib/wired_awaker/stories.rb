class WiredAwaker::Stories
  attr_accessor :title, :story_body, :url, :weekday_id
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

end
