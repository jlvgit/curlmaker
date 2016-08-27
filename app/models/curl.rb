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

  validates :name, :method, :headers, :url, :service, :data,
            presence: { :message => "cannot be blank" }
  validates :data, json: { message: "is not a valid json object", schema: PROFILE_JSON_SCHEMA }
end
