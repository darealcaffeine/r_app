require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                        :content => "Ruby on Rails Tutorial Sample App | Home")
    end
   
    it "should display the number of microposts in sidebar" do
      @user = test_sign_in(Factory(:user))
      mp1 = Factory(:micropost, :user => @user, :content => "foo bar")
      get 'home'
      response.should have_selector("td.sidebar", :content => "1 micropost")
    end

 
  end

  describe "GET 'contact'" do
    
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "GET 'about'" do
   
     it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | About")
    end
  end
end

