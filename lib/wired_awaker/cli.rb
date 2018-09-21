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
    @awaker = WiredAwaker::Stories
    weekday = nil
    puts "Type 1-5 or the weekday you want top news for - Ex. type Tuesday or 2 \n"
  
    while weekday != "exit"
      #puts "\n Would you like to read more?"
      weekday = gets.chomp.downcase
      case weekday
      when "1","monday"
        puts "Select which Monday to read more about"
        puts "You can also type exit / Select different weekday: \n "
        @awaker.scrape_weekday(1)
      when "2","tuesday"
        puts "Select which Tuesday to read more about"
        puts "You can also type exit / Select different weekday: \n "
        @awaker.scrape_weekday(2) 
      when "3","wednesday"
        puts "Select which Wednesday to read more about"
        puts "You can also type exit / Select different weekday: \n "
        @awaker.scrape_weekday(3)
      when "4","thursday"
        puts "Select which Thursday to read more about"
        puts "You can also type exit / Select different weekday: \n "
        @awaker.scrape_weekday(4)
      when "5","friday"
        puts "Select which Friday to read more about"
        puts "You can also type exit / Select different weekday: \n "
        @awaker.scrape_weekday(5)
      when "exit"
        weekday = "exit"
      else
        puts " \n Sorry didn't catch that - Please enter a weekday by name / number or exit. \n"
      end
    end
  end

  def byebye
    puts "Good to see you!"
  end
end
