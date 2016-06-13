require 'spec_helper'
require 'net/http'
require 'json'
require 'selenium-webdriver'

describe "Given I am a website user", :type => :feature do

  ['http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/',
   'http://spa2016.roberthargreaves.net.global.prod.fastly.net/'].each do |url|

    context 'url is ' + url do

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
        @site_url = url
        Capybara.default_driver = :remote_browser
        Capybara.javascript_driver = :remote_browser
      end

      it 'loads the page' do
        visit @site_url
        expect(page).to have_content 'clouds'
      end

      it 'loads the page fully in under 2 seconds' do
        stopwatch = Stopwatch.new
        visit @site_url
        expect(stopwatch.elapsed_time).to be < 2
      end

      it 'has up-to-date counter' do
        api_counter_value = get_counter_value_from_api
        page_counter_value = get_counter_value_from_page
        puts "API counter is #{api_counter_value}, Page is #{page_counter_value}"
        expect(page_counter_value).to be >= api_counter_value
      end

    end

  end

  def get_counter_value_from_api
    api_url = 'http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/'
    uri = URI(api_url + 'counter')
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    val = data["value"]
    val
  end

  def get_counter_value_from_page
    visit @site_url
    page_counter_value = find('#counter').text
    page_counter_value = page_counter_value.scan(/\d+/).join().to_i
    page_counter_value
  end

end
