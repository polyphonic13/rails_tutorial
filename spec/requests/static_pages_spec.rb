require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
  
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Sample App')
    end
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => " | Home")
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end
  # 
  # describe "Help page" do
  #   
  #   it "should have the content 'Help'" do
  #     visit '/static_pages/help'
  #     page.should have_selector('h1', :text => 'Help')
  #   end
  #   it "should have the right title" do
  #     visit '/static_pages/help'
  #     page.should have_selector('title', :text => " | Help")
  #   end
  # end
  # 
  # describe "About page" do
  #   it "should have the content 'About'" do
  #     visit '/static_pages/about'
  #     page.should have_selector('h1', :text => 'About Us')
  #   end
  #   it "should have the right title" do
  #     visit '/static_pages/about'
  #     page.should have_selector('title', :text => " | About")
  #   end
  # end
  # 
  # describe "Contact page" do
  #   it "should have the h1 'Contact'" do
  #     visit '/static_pages/contact'
  #     page.should have_selector('h1', :text => 'Contect')
  #   end
  #   it "shoudl have the right title" do
  #     visit '/static_pages/contact'
  #     page.should have_selector('title', :text => " | Contact")
  #   end
  # end
end