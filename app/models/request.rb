class Request < ActiveRecord::Base
  require 'open-uri'
  attr_accessible :ip, :method, :timestamp, :url

  scope :timestamps, lambda {|start_at, end_at| where(timestamp: start_at..end_at)}
  scope :with_method, lambda {|method| where(method: method)}

  #https://dl.dropbox.com/s/4xisu6iaz1t2jyz/eventick_parsed.log?dl=1
  #https://dl.dropbox.com/s/r4klddlxwvzaim4/eventick.log?dl=1
  def self.parse_file
  	open('https://dl.dropbox.com/s/4xisu6iaz1t2jyz/eventick_parsed.log?dl=1') do |file|
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
    now = DateTime.now - 4.day

    0.upto(23) do |i|
      entry = Hash.new
      start_hour = now.change(hour: i)
      end_hour = now.change(hour: (i + 1))  
      results[i] = Request.timestamps(start_hour, end_hour).count(group: "method")
    end
    results
  end

  def self.get_urls
    results = Hash.new
    now = DateTime.now - 4.day

    0.upto(23) do |i|
      entry = Hash.new
      start_hour = now.change(hour: i)
      end_hour = now.change(hour: (i + 1))  
      request_per_hour = Request.timestamps(start_hour, end_hour).count(group: "url")
      sorted = request_per_hour.sort { |l,r| l[1] <=> r[1] }

      results[i] = sorted[-10..-1]
    end
    results
  end
end
