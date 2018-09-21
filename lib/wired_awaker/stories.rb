class WiredAwaker::Stories
  attr_accessor :title, :story_body, :url
  @@all = []

  def initialize
    @title = title
    @story_body = story_body
    @url = url
    @@all << self
  end

  def self.scrape_stories
    doco = Nokogiri::HTML(open("https://www.wired.co.uk/topic/wired-awake"))
    doco.css("li article").map{ |stories|
      s = self.new
      s.title = stories.css("a").text
    }
  end

  def self.scrape_weekday(weekday)
    doco = Nokogiri::HTML(open("https://www.wired.co.uk/topic/wired-awake"))
    selected_weekday = Date::DAYNAMES[weekday]
    @selected_stories = []
    @selected_urls = []

    doco.css("li article").map { |stories|
      s = self.new
      s.title = stories.css("a").text
      s.url = stories.css("a").attribute("href").value
    }

    self.all.map { |h|
      if h.title.include?(selected_weekday)
        @selected_stories << h.title unless @selected_stories.include?(h.title)
        @selected_urls << h.url unless @selected_stories.include?(h.url)
        #should I change initialize to take in a hash instead of having these two arrays?
      end
    }

    @selected_stories.each.with_index(1) do |h, i|
      puts "#{i}. #{h}"
    end

  end

  def self.scrape_url(selected)
    conv = selected.to_i-1
    url_completer = "https://www.wired.co.uk" + "#{@selected_urls[conv]}"
    doco_three = Nokogiri::HTML(open("#{url_completer}"))
    story = {}
    lead_titles = []
    lead_stories = []

    lead_titles << doco_three.css("h2.bb-h2").collect{|l| l.text }
    lead_stories << doco_three.search("div p.bb-p").collect{|l| l.text }
    story[:title] = doco_three.search("h1.a-header__title").text


      binding.pry
  end

  def self.all
    @@all
  end

end
