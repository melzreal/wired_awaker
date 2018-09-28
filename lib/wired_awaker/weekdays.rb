class WiredAwaker::WeekDays
  attr_accessor :title, :story_body, :url

  def initialize
      @@all << self
  end


  def self.all
    @@all
  end


end
