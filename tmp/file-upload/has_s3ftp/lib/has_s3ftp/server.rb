module HasS3ftp
  class Server

    def initialize(s3ftp_config)
      @s3ftp_config = s3ftp_config
    end

    def notification_error(error)
      if @s3ftp_config[:notification]
        email_client.mail.send(:to => @s3ftp_config[:email], :subject => "[HAS_S3FTP]: ERROR", :text => error, :from => "no-reply@has_s3ftp.com")
      end
    end

    def email_client
      SendGridWebApi::Client.new(@s3ftp_config[:sendgrid_username], @s3ftp_config[:sendgrid_password])
    end

    def start
      begin
        EM::FTPD::App.start(File.dirname(__FILE__) + "/../../config/config.rb")
      rescue => error
        puts "Server can't start, it returns the following error: #{error.message}"
        notification_error(error.message)
      end
    end

    def pid_file
      "/var/run/has_s3ftp.pid"
    end

    def stop
      begin
        if File.exists?(pid_file)
          Process.kill 9, File.read(pid_file).to_i
        else
          puts "PidFile not exists, please check if the server was started"
        end
      rescue Errno::ESRCH
        puts "No such process, please check if the server was started"
      rescue => error
        puts "Error when tried to stop the server, please check if the server was started"
        notification_error(error.message)
      ensure
        FileUtils.rm_f(pid_file)
      end
    end
  end
end