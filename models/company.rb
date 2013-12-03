class Company < ActiveRecord::Base
  has_many :directors

  validates :name, :address, :city, :country, presence: true

  # Returns a JSON representation of the company,
  # optionally including an array of directors
  def json_representation(directors = false)
    Jbuilder.encode do |json|
      json.extract! self, :id, :name, :address, :city, :country, :email, :phone

      json.directors self.directors, :id, :name if directors 
    end
  end
end