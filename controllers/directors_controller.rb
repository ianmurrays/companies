class Application < Sinatra::Base
  def clean_director(unsafe_params)
    # Remove dangerous parameters, keep only the ones we want
    safe_params = unsafe_params.select do |key, value|
      %w{name passport passport_cache}.include? key.to_s
    end

    safe_params
  end

  #
  # Routes
  #

  get '/companies/:company_id/directors/:id' do |company_id, id|
    director_params = clean_director(@request_payload)
    company = find_company(company_id)
    director = company.directors.find_by_id(id)

    halt 404 unless director
    director.json_representation
  end

  get '/companies/:company_id/directors/:id/passport' do |company_id, id|
    director_params = clean_director(@request_payload)
    company = find_company(company_id)
    director = company.directors.find_by_id(id)

    halt 404 unless director and director.passport?
    redirect director.passport.url
  end

  post '/companies/:company_id/directors' do |company_id|
    director_params = clean_director(@request_payload)
    puts director_params.inspect
    company = find_company(company_id)

    director = Director.new 
    director.name = director_params["name"]
    director.passport_cache = director_params["passport_cache"]

    puts director_params["passport_cache"]["passport_cache"]

    director.company = company

    if director.save!
      status 202
      director.json_representation
    else
      render_errors(company)
    end
  end

  # Simply caches the passport and returns an id
  post '/companies/:company_id/directors/upload' do |company_id|
    director_params = clean_director(params)
    company = find_company(company_id)

    director = Director.new
    director.passport = params[:passport]

    {passport_cache: director.passport_cache}.to_json
  end

  put '/companies/:company_id/directors/:id' do |company_id, id|
    director_params = clean_director(@request_payload)
    company = find_company(company_id)
    director = company.directors.find_by_id(id)

    halt 404 unless director

    if director.update_attributes director_params
      status 202
      director.json_representation
    else
      render_errors(director)
    end
  end

  delete '/companies/:company_id/directors/:id' do |company_id, id|
    company = find_company(company_id) # Validate the company exists
    director = company.directors.find_by_id(id)

    director.destroy

    status 204 # No content
  end
end