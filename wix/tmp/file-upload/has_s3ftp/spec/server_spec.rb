require 'spec_helper'

describe HasS3ftp::Server do
  let(:server) {HasS3ftp::Server.new({:aws_key=>"aws-key", :aws_secret=>"aws-secrect", :aws_bucket=>"ftp-chebyte", :email=>"email"}) }

  context "#email_client" do
    it "should create a new instance of sendgrid" do
      server.email_client.should be_an_instance_of(SendGridWebApi::Client)
    end
  end

  context "#notification_error" do
    it "should call to mail method" do
      error = mock("error")
      mail  = mock("email")
      server.email_client.stub!(:mail).and_return(mail)
      mail.stub!(:send).and_return(true)
      server.notification_error(error)
    end
  end

  context "#pid_file" do
    it "should return pid file" do
      server.pid_file.should eql "/var/run/has_s3ftp.pid"
    end
  end

  context "#stop" do
    before(:each) do
      FileUtils.should_receive(:rm_f)
    end
    it "should return error if pid file not exists" do
      File.should_receive(:exists?).and_return do 
        raise Errno::ESRCH
      end
      STDOUT.should_receive(:puts).with('No such process, please check if the server was started')
      server.stop
    end

    it "should return error if something wrong happeness" do
      File.should_receive(:exists?).and_return do 
        raise "Error"
      end
      STDOUT.should_receive(:puts).with("Error when tried to stop the server, please check if the server was started")
      server.should_receive(:notification_error)
      server.stop
    end
  end
end