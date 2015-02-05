s3ftp_config = HasS3ftp::Command.get_api_key

driver        S3FTP::Driver
driver_args   s3ftp_config[:aws_key], s3ftp_config[:aws_secret], s3ftp_config[:aws_bucket]

port          s3ftp_config[:port]
daemonise     s3ftp_config[:daemonize]
name          s3ftp_config[:user]
pid_file      s3ftp_config[:pidfile]