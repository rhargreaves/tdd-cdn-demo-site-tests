require 'spec_helper'

describe "Given I am a website user", :type => :feature do

  before do
    Capybara.current_driver = :selenium
  end

  it 'loads the page' do

    visit "http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/"
    expect(page).to have_content 'Clouds'
  end
end
