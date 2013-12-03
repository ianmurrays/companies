require "./config/boot"
require "active_record"

# Connect to the database
env = ENV["RACK_ENV"] ? ENV["RACK_ENV"] : "development"
config = YAML::load(File.open('config/database.yml'))[env]
ActiveRecord::Base.establish_connection(config)

# Application Configuration
class Application < Sinatra::Base
  before do
    content_type 'application/json'

    # Client should post raw JSON
    begin
      request.body.rewind
      @request_payload = JSON.parse request.body.read
    rescue JSON::ParserError
      @request_payload = {}
    end
  end

  # Finds a company or renders a 404
  def find_company(company_id)
    company = Company.find_by_id(company_id)
    halt 404 unless company

    company
  end

  def render_errors(object)
    status 422 # unprocessable entity
    {:error => :validation_failed, :errors => object.errors.full_messages}.to_json
  end
end

# Models
require "./models/passport_uploader"
require "./models/company"
require "./models/director"

# Controllers
require "./controllers/companies_controller"
require "./controllers/directors_controller"
