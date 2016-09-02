class Curl < ApplicationRecord
  serialize :data, JSON
  validates :name, :method, :headers, :url, :service,
            presence: { :message => "cannot be blank" }

  validate :json_format, if: 'data.present?'

protected

  def json_format
    errors[:base] << "Data is not valid json" unless data.is_json?
  end
end
