class WiredAwaker::CLI

  def fetcher
    WiredAwaker::Scraper.scrape_stories
    show_main
    choose_weekday
    byebye
  end

  def show_main
    puts "Here are the headlines for the last #{WiredAwaker::WeekDays.all.size} days of wired awake stories: \n "
    stories = WiredAwaker::WeekDays.all
    stories.each.with_index(1) do |story, i|
      puts "#{i}. #{story.title}"
    end
  end

  def choose_weekday

    weekday = nil

    while weekday != "exit"
      puts "Type 1-#{WiredAwaker::WeekDays.all.size} for the weekday you want to see top news for"
      puts "type list to see your weekday options again"
      puts "or type exit to leave \n"
      weekday = gets.chomp
     if weekday.to_i > 0 && weekday.to_i <= WiredAwaker::WeekDays.all.size
        if  WiredAwaker::Stories.all.map{|s| s.weekday_id}.include?(weekday.to_i)
           WiredAwaker::Stories.all.each do  |s|
             s == weekday.to_i
             puts "\n #{s.title} #{s.story_body} \n" 
            end
        else
          WiredAwaker::Scraper.scrape_url(weekday.to_i)
        end
      elsif weekday == "exit"
            weekday = "exit"
      elsif weekday == "list"
        show_main
      else
            puts " \n Sorry didn't catch that - Please enter a number from 1-12 or exit. \n"
      end
    end

  end

  def byebye
    puts "Good to see you!"
  end
end
