require 'spec_helper'
require 'net/http'
require 'json'

describe "Given I am a website user", :type => :feature do

  before do
    Capybara.current_driver = :selenium
    @site_url = "http://robh-spa-2016-demo-site.eu-west-1.elasticbeanstalk.com/"
  end

  it 'loads the page' do
    visit @site_url
    expect(page).to have_content 'Clouds'
  end

  it 'loads the page fully in under 5 seconds' do
    stopwatch = Stopwatch.new
    visit @site_url
    expect(stopwatch.elapsed_time).to be < 5
  end

  it 'has up-to-date counter' do
    api_counter_value = get_counter_value_from_api
    page_counter_value = get_counter_value_from_page
    expect(page_counter_value).to be >= api_counter_value
  end

  def get_counter_value_from_api
    uri = URI(@site_url + 'counter')
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
