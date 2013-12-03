class Application < Sinatra::Base
  def clean_params(unsafe_params)
    # Remove dangerous parameters, keep only the ones we want
    safe_params = unsafe_params.keep_if do |key, value|
      %w{name address city country email phone}.include? key.to_s
    end

    safe_params
  end

  #
  # Routes
  #

  get '/companies' do
    Jbuilder.encode do |json|
      json.array! Company.all
    end
  end

  get '/companies/:id' do |company_id|
    company = find_company(company_id)

    halt 404 unless company

    company.json_representation(true)
  end

  post '/companies' do
    company = Company.new clean_params(params[:company])

    if company.save
      company.json_representation
    else
      render_errors(company)
    end
  end

  put '/companies/:id' do |company_id|
    company = find_company(company_id)

    if company.update_attributes clean_params(params[:company])
      company.json_representation
    else
      render_errors(company)
    end
  end

  delete '/companies/:id' do |company_id|
    company = find_company(company_id)
    company.destroy

    status 204 # No content
  end
end