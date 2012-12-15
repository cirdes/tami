class Request < ActiveRecord::Base
  require 'open-uri'
  attr_accessible :ip, :method, :timestamp, :url
  
  def self.parse_file
  	open('https://dl.dropbox.com/s/r4klddlxwvzaim4/eventick.log?dl=1') do |file|
  		file.each_line do |line|
  			if line =~ /.*Started.*/
  				timestamp = line.scan(/\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d -\d\d\d\d/).first
  				ip = line.scan(/\d+\.\d+\.\d+\.\d+/).first
  				url = line.scan(/".+"/).first
  				method = line.scan(/GET|PUT|POST|DELETE/).first
  				Request.create(ip: ip, timestamp: timestamp, url: url, method: method)
  			end
  		end
  	end
  end
end
