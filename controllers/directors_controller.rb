class Application < Sinatra::Base
  def clean_params(unsafe_params)
    # Remove dangerous parameters, keep only the ones we want
    safe_params = unsafe_params.keep_if do |key, value|
      %w{name}.include? key.to_s
    end

    safe_params
  end

  #
  # Routes
  #

  post '/companies/:company_id/directors' do |company_id|
    director_params = clean_params(params[:director])
    company = find_company(company_id)

    director = company.directors.build director_params

    if company.save
      status 202
      director.json_representation
    else
      render_errors(company)
    end
  end

  put '/companies/:company_id/directors/:id' do |company_id, id|
    director_params = clean_params(params[:director])
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