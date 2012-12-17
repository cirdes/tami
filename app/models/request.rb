class Request < ActiveRecord::Base
  require 'open-uri'
  attr_accessible :ip, :method, :timestamp, :url

  scope :timestamps, lambda {|start_at, end_at| where(timestamp: start_at..end_at)}
  scope :with_method, lambda {|method| where(method: method)}

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

  def self.get_methods
    results = Hash.new
    now = DateTime.now
    0.upto(23) do |i|
      entry = Hash.new
      
      entry["GET"] = method_count("GET", i, now)
      entry["PUT"] = method_count("PUT", i, now)
      entry["POST"] = method_count("POST", i, now)
      entry["DELETE"] = method_count("DELETE", i, now)
      results[i] = entry
    end
    results
  end

  def self.method_count(method, i, now)
    start_hour = now.change(hour: i)
    end_hour = now.change(hour: (i + 1))
    Request.with_method(method).timestamps(start_hour, end_hour).count
  end
end
