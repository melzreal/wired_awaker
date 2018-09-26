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
      s.url = stories.css("a").attribute("href").value
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
        @selected_urls << h.url unless @selected_urls.include?(h.url)
      end
    }

    @selected_stories.each.with_index(1) do |h, i|
      puts "#{i}. #{h}"
    end

  end

   def self.scrape_url(selected)
    self.scrape_stories
    conv = selected.to_i-1
    urls_collection = self.all.collect{|s| s.url }
    chosen_day =  urls_collection[conv]

    @url_completer = "https://www.wired.co.uk" + "#{chosen_day}"
    doco_three = Nokogiri::HTML(open("#{@url_completer}"))
    titles = []
    stories = []

      doco_three.search("h2.bb-h2")[0..-3].collect{ |s|
        unless s.text.include?("Popular on WIRED")
         titles << s.text
        end
      }

      doco_three.search("/html/body/article/div/div/div/p")[2..-5].collect{ |s|
       stories << s.text
     }

      [titles,stories].transpose.each do |title, story|
        mm = self.new
        mm.title = title
        mm.story_body = story
        puts "#{mm.title} #{mm.story}"
      end

      #binding.pry

  end


  def self.all
    @@all
  end

end
