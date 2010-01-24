require 'core_ext'

class SCEA
  class TweetBot
  
    # Metaprogramming to add class ivar accessors to inheriting classes
    class << self
      attr_accessor :hourly_method, :daily_method, :daily_trigger_time, :weekly_method
      attr_accessor :weekly_trigger_time, :twitter_creds, :api_creds, :api_url
    end

    # Class instance variable setters
      def self.trigger_hourly(method_to_call)
        @hourly_method = method_to_call
      end

      def self.trigger_daily(method_to_call, trigger_time="00:00 - PST")
        @daily_method = method_to_call
        @daily_trigger_time = trigger_time  # TODO: parse
      end

      def self.trigger_weekly(method_to_call, trigger_time="Sunday - 00:00 - PST")
        @weekly_method = method_to_call
        @weekly_trigger_time = trigger_time  # TODO: parse
      end

      def self.twitter_credentials(creds)
        @twitter_creds = creds
      end

      def self.game_api_credentials(creds)
        @api_creds = creds
      end

      def self.game_api_url(url)
        @api_url = url
      end
    # end of class instance variable setters
  
  
    def initialize
      klass = self.class
      create_hourly_cronjob(klass.hourly_method) if klass.hourly_method
      create_daily_cronjob(klass.daily_method, klass.daily_trigger_time) if klass.daily_method
      create_weekly_cronjob(klass.weekly_method, klass.weekly_trigger_time) if klass.weekly_method
    end
  
    # instance methods
  
    def create_hourly_cronjob(meth_string)
      # TODO, make sure we have an hourly cronjob requiring this file and calling
      # self.class.new.send(meth_string)
      # otherwise create one
    end
  
    def create_daily_cronjob(meth_string, trigger_time) 
      # TODO 
    end
  
    def create_weekly_cronjob(meth_string, trigger_time)
      # TODO
    end
    
    def data_file
      File.expand_path("#{self.class.name}_last_run")
    end
    
    def load_data(key)
       Marshal.load(File.open(data_file))[key]
    end
    
    def save_data(key, value)
      data = load_data[key] = value
      File.open(data_file, 'w+'){|f| f << Marshal.dump(data)}
    end
  
    def tweet(message)
      "post tweet using #{twitter_creds.inspect}"
    end
    
    def method_missing(meth, *args, &block)
      if self.class.respond_to?(meth)
        args.empty? ? self.class.send(meth) : self.class.send(meth, args)
      else
        super
      end
    end
  
  end
  
end