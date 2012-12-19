class ApplicationController < ActionController::Base
	after_filter :set_access_control_headers

	def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
  end
end
