module ApplicationHelper

  class String
    def is_json?
      begin
        !!JSON.parse(self)
      rescue
        false
      end
    end
  end

  def all_messages

  # Standard flash messages
  messages = flash.map{|key,val| {:type=>key, :message=>val} unless val.blank? }.compact
    #                                                        |-------------------------|
    # This is where the magic happens. This is how I ignore any blank messages

  # Model validation errors
  model = instance_variable_get("@#{controller_name.singularize}")
  unless model.nil?
    messages += model.errors.full_messages.map do |msg|
      {:type=>:error, :message=>msg}
    end
  end

  return messages

  end
end
