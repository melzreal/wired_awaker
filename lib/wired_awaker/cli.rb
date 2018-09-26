class WiredAwaker::CLI

  def fetcher
    show_main
    choose_weekday
    byebye
  end

  def show_main
    puts "Here are the headlines for the last 12 days of wired awake stories: \n "
    @stories = WiredAwaker::Stories.scrape_stories
    @stories.each.with_index(1) do |story, i|
      puts "#{i}. #{story}"
    end
  end

  def choose_weekday
    weekday = nil
    @awaker = WiredAwaker::Stories
    while weekday != "exit"
      puts "Type 1-12 for the weekday you want to see top news for \n"
      weekday = gets.chomp
        case weekday
        when "1"
            @awaker.scrape_url(1)
        when "2"
            @awaker.scrape_url(2)
        when "3"
            @awaker.scrape_url(3)
        when "4"
            @awaker.scrape_url(4)
        when "5"
            @awaker.scrape_url(5)
        when "6"
            @awaker.scrape_url(6)
        when "7"
            @awaker.scrape_url(7)
        when "8"
            @awaker.scrape_url(8)
        when "9"
            @awaker.scrape_url(9)
        when "10"
            @awaker.scrape_url(10)
        when "11"
            @awaker.scrape_url(11)
        when "12"
            @awaker.scrape_url(12)
        when "exit"
            weekday = "exit"
        else
            puts " \n Sorry didn't catch that - Please enter a number from 1-12 or exit. \n"
        end
    end
  end

  def byebye
    puts "Good to see you!"
  end
end
