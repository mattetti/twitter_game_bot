if Kernel.respond_to?(:require_relative)
  require_relative 'helper'
else
  require File.join(File.dirname(__FILE__), 'spec_helper')
end

class NBABot < SCEA::TweetBot; 
  trigger_hourly        :hourly_tweet
  trigger_daily         :tweet_top_5, "14:00 - PST"
  trigger_weekly        :tweet_weekly_stats, "Monday - 15:00 - PST"
  
  twitter_credentials   :login => 'nba', :password => 'sekrit'
  game_api_credentials  :login => 'nbaapi', :password => 'sekrit'
  game_api_url          'http://nba.com/billiejean/'
end

class MBLBot < SCEA::TweetBot; 
  trigger_daily         :league_results
  trigger_weekly        :leaderboard_results,  "Friday - 13:00 - PST"
  
  twitter_credentials   :login => 'mbl', :password => 'sekrit'
  game_api_credentials  :login => 'mblapi', :password => 'sekrit'
  game_api_url          'http://mbl.com/thriller/'
end

describe "SCEA:TweetBot game" do
  
  before(:all) do
    @nba_bot  = NBABot.new
    @mbl_bot  = MBLBot.new
  end
  
  describe "triggers" do
    it "can have an optional unique hourly tweet method" do
      @nba_bot.hourly_method.should == :hourly_tweet
      @mbl_bot.hourly_method.should be_nil
    end
  
    it "can have an optional unique daily tweet method" do
      @nba_bot.daily_method.should == :tweet_top_5
      @mbl_bot.daily_method.should == :league_results
    end
  
    it "has a daily trigger time" do
      @nba_bot.daily_trigger_time.should == "14:00 - PST"
      @mbl_bot.daily_trigger_time.should == "00:00 - PST"
    end
  
    it "can have an optional unique weekly tweet method" do
      @nba_bot.weekly_method.should == :tweet_weekly_stats
      @mbl_bot.weekly_method.should == :leaderboard_results
    end
  
    it "has a weekly trigger time" do
      @nba_bot.weekly_trigger_time.should == "Monday - 15:00 - PST"
      @mbl_bot.weekly_trigger_time.should == "Friday - 13:00 - PST"
    end
  end
  
  describe "twitter credentials" do
    it "should have a twitter login" do
      @nba_bot.twitter_creds.should_not be_nil
      @nba_bot.twitter_creds[:login].should == 'nba'
      @mbl_bot.twitter_creds.should_not be_nil
      @mbl_bot.twitter_creds[:login].should == 'mbl'
    end
    it "should have a twitter password" do
      @nba_bot.twitter_creds[:password].should == 'sekrit'
      @mbl_bot.twitter_creds[:password].should == 'sekrit'
    end
  end
  
  describe "game api" do
    it "should have an game API login" do
      @nba_bot.api_creds.should_not be_nil
      @nba_bot.api_creds[:login].should == 'nbaapi'
      @mbl_bot.api_creds.should_not be_nil
      @mbl_bot.api_creds[:login].should == 'mblapi'
    end
    it "should have an game API password" do
      @nba_bot.api_creds.should_not be_nil
      @nba_bot.api_creds[:password].should == 'sekrit'
      @mbl_bot.api_creds.should_not be_nil
      @mbl_bot.api_creds[:password].should == 'sekrit'
    end
    it "should have a game API url" do
      @nba_bot.api_url.should == 'http://nba.com/billiejean/'
      @mbl_bot.api_url.should == 'http://mbl.com/thriller/'
    end
  end
  
end