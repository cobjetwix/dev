require 'spec_helper'

describe HasS3ftp::Command do
  let(:command) { HasS3ftp::Command }

  context "#api_key_file" do
    it "should return api_key_file path" do
      command.api_key_file.should eql "/tmp/.has_s3ftp/config"
    end
  end

  context "#write_api_key" do
    it "should create config file" do
      api_key_file = mock("api_key_file")
      api_key_file.should_receive(:to_path).and_return("path")
      File.should_receive(:dirname).and_return(api_key_file)
      File.should_receive(:open).and_return(api_key_file)
      command.stub!(:set_api_key_permissions)
      command.write_api_key
    end
  end

  context "#read_api_key" do
    it "should return nil if config file doesn't exist" do
      File.should_receive(:exists?).and_return(false)
      command.read_api_key.should be_nil
    end

    it "should load config file into hash" do
      api_key_file = "--- \n:aws_key: \"aws-key\" \n:aws_secret: \"aws-secrect\" \n:aws_bucket: \"ftp-chebyte\"\n:email: \"email\"\n"
      yaml_api_key_file = YAML::load(api_key_file)
      File.should_receive(:exists?).and_return(true)
      File.should_receive(:read).and_return(api_key_file)
      YAML.should_receive(:load).and_return(yaml_api_key_file)
      s3ftp_config = command.read_api_key
      s3ftp_config[:aws_key].should eql "aws-key"
      s3ftp_config[:aws_secret].should eql "aws-secrect"
      s3ftp_config[:aws_bucket].should eql "ftp-chebyte"
      s3ftp_config[:email].should eql "email"
    end
  end

  context "#get_api_key" do
    it "should write a new file if it doesn't exist" do
      command.should_receive(:read_api_key).and_return(false)
      command.should_receive(:ask_for_api_key)
      command.should_receive(:write_api_key)
      command.get_api_key
    end

    it "should load file config if it exist" do
      command.should_receive(:read_api_key).and_return(true)
      command.should_not_receive(:ask_for_api_key)
      command.should_not_receive(:write_api_key)
      command.get_api_key
    end
  end

end
