require 'spec_helper'

describe "Given I am a website user", :type => :feature do

  before do
    Capybara.current_driver = :selenium
  end

  it 'loads the page' do
    visit "http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/"
    expect(page).to have_content 'Clouds'
  end

  it 'loads the page in under 5 seconds' do
    stopwatch = Stopwatch.new
    visit "http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/"
    expect(stopwatch.elapsed_time).to be < 5
  end
end
