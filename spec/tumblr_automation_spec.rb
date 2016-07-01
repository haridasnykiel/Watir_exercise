require 'spec_helper.rb'

describe "Tumblr tests" do

    let(:driver) { Watir::Browser.new}
    # let(:wait) { Watir::Wait.until(600)}

    # ep = YAML.load(File.open("login_info.yml"))


  it "Load YAML file, should username and password." do
    @ep = YAML.load(File.open("./spec/login_info.yml"))["Account"]
    expect(@ep.to_a.size).to eq 2
    expect(@ep["email"]).to eq "haridasnykiel@gmail.com"
    expect(@ep["password"]).to eq "hello123"
  end


  it "Should be able to login to tumblr" do
    @ep = YAML.load(File.open("./spec/login_info.yml"))["Account"]
    # binding.pry
    driver.goto("https://www.tumblr.com")
    # binding.pry
    b = driver.button id: "signup_login_button"
    b.when_present.click


    e = driver.text_field(id: "signup_determine_email")
    e.when_present.set(@ep["email"])
    # binding.pry
    n = driver.button id: "signup_forms_submit"
    n.when_present.click
    # binding.pry
    p = driver.text_field(id: "signup_password")
    p.when_present.set(@ep["password"])
    # binding.pry
    login = driver.button id: "signup_forms_submit"
    login.when_present.click
    # binding.pry
    expect(driver.url).to eq "https://www.tumblr.com/dashboard"

  end

  it "Should be able to post a text post." do
    
  end


end
