module HasS3ftp
  module Command
    attr_accessor :api_key_hash
    extend self

    def ask
      $stdin.gets.strip
    end

    def api_key
      get_api_key
    end

    def api_key_file
      "#{ENV['HOME']}/.has_s3ftp/config"
    end

    def get_api_key
      unless @api_key_hash = read_api_key
        @api_key_hash = ask_for_api_key
        write_api_key
      end
      @api_key_hash
    end

    def read_api_key
      if File.exists? api_key_file
        return YAML::load(File.read(api_key_file))
      end
    end

    def write_api_key
      FileUtils.mkdir_p(File.dirname(api_key_file))
      File.open(api_key_file, 'w') do |f|
        f.write @api_key_hash.to_yaml
      end
      set_api_key_permissions
    end

    def set_api_key_permissions
      FileUtils.chmod 0700, File.dirname(api_key_file)
      FileUtils.chmod 0600, api_key_file
    end

    def ask_for_api_key
      puts "Enter your S3 Account"

      print "aws key: "
      aws_key = ask

      print "aws secret: "
      aws_secret = ask

      print "aws bucket: "
      aws_bucket = ask

      config_hash = {
        :aws_key => aws_key,
        :aws_secret => aws_secret,
        :aws_bucket => aws_bucket,
        :port => 21,
        :daemonize => true,
        :user => 'deploy',
        :pidfile => '/var/run/has_s3ftp.pid',
      }

      print "do you want support notification errors by email? (y/n)"
      notification = ask

      if notification.empty? || notification == "y"
        print "email notification: "
        email = ask

        print "sendgrid username: "
        sendgrid_username = ask

        print "sendgrid password: "
        sendgrid_password = ask

        config_hash.merge!(:email => email, :notification => notification,
                           :sendgrid_username => sendgrid_username,
                           :sendgrid_password => sendgrid_password)
      end
      puts "The config file was created: #{api_key_file}"
      config_hash
    end

  end
end