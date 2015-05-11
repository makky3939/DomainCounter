require 'capybara'
require 'selenium-webdriver'

Capybara.current_driver = :selenium

module Crowler
  class Google
    include Capybara::DSL

    def search keyword
      visit URI.escape "https://www.google.com/search?q=site:.#{keyword}"
      result = all('#resultStats').first

      if result.nil?
        return 0
      else
        result.text.match(/(\d+,)*\d+/)[0].gsub(',', '').to_i
      end
    end
  end

  class Bing
    include Capybara::DSL

    def search keyword
      visit URI.escape "https://www.bing.com/search?q=site:.#{keyword}"
      result = all('.sb_count').first

      if result.nil?
        return 0
      else
        result.text.match(/(\d+,)*\d+/)[0].gsub(',', '').to_i
      end
    end
  end
end