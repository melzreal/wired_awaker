class WiredAwaker::Scraper

  def self.scrape_stories
    doco = Nokogiri::HTML(open("https://www.wired.co.uk/topic/wired-awake"))
    doco.css("li article").map{ |stories|
      s = WiredAwaker::WeekDays.new
      s.url = stories.css("a").attribute("href").value
      s.title = stories.css("a").text
      #s.day_stories = []
    }
  end


  def self.scrape_url(selected)
    conv = selected.to_i-1
    urls_collection = WiredAwaker::WeekDays.all.collect{|s| s.url }
    chosen_day =  urls_collection[conv]

    @url_completer = "https://www.wired.co.uk" + "#{chosen_day}"
    puts "*********Scraping url*********"
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
        mm = WiredAwaker::Stories.new
        mm.title = title
        mm.story_body = story
        puts "\n #{mm.title} \n #{mm.story_body} \n"
        #WiredAwaker::WeekDays.stories=(mm)
      end

  end

end
