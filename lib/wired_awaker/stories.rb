class WiredAwaker::Stories
  attr_accessor :title, :story_body, :url
  @@all = []

  def initialize
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
    stories = {}

      titles = doco_three.search("h2.bb-h2").collect{ |s|
        mm = self.new
        mm.title = s.text unless s.text == "Popular on WIRED"
      }

     sto = doco_three.search("/html/body/article/div/div/div/p")[2..-5].collect{ |s|
        
         stories[:story_body] = s.children.text
      }

      binding.pry

     #titles = titles.slice!(-1)

     #self.all.map { |h|
    #   puts "#{h.title} \n #{h.story_body}"
     #}


  end

  def self.all
    @@all
  end

end
