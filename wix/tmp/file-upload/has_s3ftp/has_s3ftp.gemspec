 # -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "has_s3ftp/version"

Gem::Specification.new do |s|
  s.name        = "has_s3ftp"
  s.version     = HasS3ftp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["chebyte"]
  s.email       = ["mauro@nexushq.com"]
  s.summary     = %q{A mini FTP server that persists all data to S3}
  s.description = %q{A mini FTP server that persists all data to S3}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["has_s3ftp"]
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_dependency "em-ftpd"
  s.add_dependency "s3ftp"
  s.add_dependency "fileutils"
  s.add_dependency "sendgrid_webapi"
end