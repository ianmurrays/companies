require 'carrierwave/orm/activerecord'

class Director < ActiveRecord::Base
  belongs_to :company
  mount_uploader :passport, PassportUploader

  def json_representation
    Jbuilder.encode do |json|
      json.extract! self, :id, :name, :company_id
    end
  end
end