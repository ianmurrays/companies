require 'carrierwave/orm/activerecord'

class Director < ActiveRecord::Base
  belongs_to :company

  attr_accessible :passport_cache
  mount_uploader :passport, PassportUploader

  validates :name, presence: true

  def json_representation
    Jbuilder.encode do |json|
      json.extract! self, :id, :name, :company_id
    end
  end
end