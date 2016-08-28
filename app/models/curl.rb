class Curl < ApplicationRecord
  serialize :data, JSON
  validates :name, :method, :headers, :url, :service, :data,
            presence: { :message => "cannot be blank" }
  validates :name, uniqueness: { case_sensitive: false }

  validate :json_format

protected

  def json_format
    errors[:base] << "Data is not valid json" unless data.is_json?
  end
end
