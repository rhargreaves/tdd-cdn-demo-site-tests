require 'spec_helper'
require 'net/http'
require 'json'
require 'selenium-webdriver'

module Tests

  origin_url = 'http://robh-cdn-tdd-demo-site.eu-west-1.elasticbeanstalk.com/'
  cdn_url = 'http://tdd-cdn-demo.roberthargreaves.net.global.prod.fastly.net/'

  entrypoints = []
  unless ENV['DO_NOT_HIT_ORIGIN']
    entrypoints.push({ :name => 'the origin', :url => origin_url })
  end
  unless ENV['DO_NOT_HIT_CDN']
    entrypoints.push({ :name => 'the CDN', :url => cdn_url })
  end

  describe "Given I am a site user", :type => :feature do

    entrypoints.each do |entrypoint|

      url = entrypoint[:url]
      context "When hitting #{entrypoint[:name]} URL" do

        before do
          selenium_url = 'http://browser:4444/wd/hub'
          Capybara.run_server = false
          Capybara.register_driver :remote_browser do |app|
            Capybara::Selenium::Driver.new(
              app,
              :browser => :remote,
              url: selenium_url,
              desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
            )
          end
          Capybara.default_driver = :remote_browser
          Capybara.javascript_driver = :remote_browser
        end

        it 'loads the page', :loads => true do
          visit url
          expect(page).to have_content 'clouds'
        end

        it 'loads the page fully in under 2 seconds', :perf => true do
          stopwatch = Stopwatch.new
          visit url
          expect(stopwatch.elapsed_time).to be < 2
        end

        it 'page has up-to-date counter', :counter => true do
          api_counter_value = get_counter_value_from_api origin_url
          page_counter_value = get_counter_value_from_page url
          expect(page_counter_value).to be >= api_counter_value, 
            "Count on page (#{page_counter_value}) less than count from API (#{api_counter_value})"
        end
      end
    end

    def get_counter_value_from_api(api_url)
      uri = URI(api_url + 'counter')
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      val = data["value"]
      val
    end

    def get_counter_value_from_page(page_url)
      visit page_url
      page_counter_value = find('#counter').text
      page_counter_value = page_counter_value.scan(/\d+/).join().to_i
      page_counter_value
    end

  end

end
