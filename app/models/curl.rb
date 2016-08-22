class Curl < ApplicationRecord
  PROFILE_JSON_SCHEMA = {
    "type": "object",
    "$schema": "http://json-schema.org/draft-04/schema",
    "properties": {
      "city": { "type": "string" },
      "country": { "type": "string" }
    },
    "required": ["country"]
  }

  validates :name, :method, :headers, :url, :service,
            presence: { :message => "cannot be blank" }
  validates :data, presence: true, json: { message: "field is not valid json", schema: PROFILE_JSON_SCHEMA }
end
