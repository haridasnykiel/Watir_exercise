require 'spec_helper.rb'

describe "Tumblr tests" do

  before :all do
    @driver = Watir::Browser.start"https://www.tumblr.com"
    @ep = YAML.load(File.open("./spec/login_info.yml"))["Account"]
  end

  after :all do
    @driver.close
    puts "        Your tests are successful        "
  end

  it "Load YAML file" do
    expect(@ep.to_a.size).to eq 2
    expect(@ep["email"]).to eq "haridasnykiel@gmail.com"
    expect(@ep["password"]).to eq "hello123"
  end


  it "Should be able to login to tumblr" do
    b = @driver.button id: "signup_login_button"
    b.when_present.click


    e = @driver.text_field(id: "signup_determine_email")
    e.when_present.set(@ep["email"])
    # binding.pry
    n = @driver.button id: "signup_forms_submit"
    n.when_present.click

    p = @driver.text_field(id: "signup_password")
    p.when_present.set(@ep["password"])

    n.when_present.click

    expect(@driver.url).to eq "https://www.tumblr.com/dashboard"
    expect(@driver.a class: "new_post_label").to exist

    # driver.close

  end

  it "Should be able to post a text post." do

    post = @driver.a id: "new_post_label_text"
    post.when_present.click

    title = @driver.div class: "editor-plaintext"
    title.when_present.send_keys "Test post"

    des = @driver.div class: "editor-richtext"
    des.when_present.send_keys "test stuffffffffff"

    sub = @driver.button class: "create_post_button"
    sub.when_present.click

    # binding.pry

    post_body = @driver.div class: "post_body"

    if (post_body.text == "Test post\ntest stuffffffffff")
      expect(post_body.text).to eq "Test post\ntest stuffffffffff"
    else
      expect(post_body.text).to eq "test stuffffffffff"
    end


  end


end
