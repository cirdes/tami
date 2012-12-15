class Request < ActiveRecord::Base
  attr_accessible :ip, :method, :timestamp, :url
end
