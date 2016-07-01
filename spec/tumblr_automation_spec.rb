require 'spec_helper.rb'

describe "Tumblr tests" do

    before :all do
      @driver = Watir::Browser.start("https://www.tumblr.com")
    end

    after :all do
      @driver.close
    end
    # let(:driver) { Watir::Browser.start("https://www.tumblr.com")}
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
    # driver.goto("https://www.tumblr.com")
    # binding.pry
    b = @driver.button id: "signup_login_button"
    b.when_present.click


    e = @driver.text_field(id: "signup_determine_email")
    e.when_present.set(@ep["email"])
    # binding.pry
    n = @driver.button id: "signup_forms_submit"
    n.when_present.click
    # binding.pry
    p = @driver.text_field(id: "signup_password")
    p.when_present.set(@ep["password"])
    # binding.pry
    login = @driver.button id: "signup_forms_submit"
    login.when_present.click
    # binding.pry
    expect(@driver.url).to eq "https://www.tumblr.com/dashboard"
    expect(@driver.a class: "new_post_label").to exist

    # driver.close

  end

  it "Should be able to post a text post." do
    # driver.goto("https://www.tumblr.com/dashboard")
    # binding.pry
    post = @driver.a id: "new_post_label_text"
    post.when_present.click
    # binding.pry
    title = @driver.div class: "editor editor-plaintext"
    title.when_present.send_keys "Test post"

    des = @driver.div class: "editor editor-richtext"
    des.when_present.send_keys "test stuffffffffff"

    sub = @driver.button class: "button-area create_post_button"
    sub.when_present.click

    # expect()
    # binding.pry
  end


end
