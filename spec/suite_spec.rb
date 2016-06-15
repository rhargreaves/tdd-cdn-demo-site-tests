require 'spec_helper'
require 'net/http'
require 'json'
require 'selenium-webdriver'

describe "Given I am a website user", :type => :feature do

  @origin_url = 'http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/'

  [@origin_url].each do |url|

    context "Url is #{url}" do

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
        # TODO
      end

    end

  end

end
