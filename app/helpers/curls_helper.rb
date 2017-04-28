module CurlsHelper

  def create_curl_text(obj, params)
    begin
      hash = JSON.parse(obj.data) unless (obj.data.nil? || obj.data.empty?)
      puts params.inspect
      params.each_pair do |key,val|
        if val != ""
          obj.url = insert_text_into_url(obj.url, key.to_s, val) unless val.is_a? Array
          val = val.reject(&:empty?)  if val.is_a? Array
          val = convert_domains(val)  if key == "domains"
          update_hash(hash, key, val) if hash
        end
      end

    if params['single-line'] || session['single-line']
      curl = "curl -X#{obj.method} "
      curl << obj.headers unless (obj.headers.nil? || obj.headers.empty?)
      curl << " #{obj.url}"
      curl << " -d '#{hash.to_json}'" if hash
    else
      curl = "curl -X#{obj.method} \\"
      curl << "\n#{obj.headers} \\" unless (obj.headers.nil? || obj.headers.empty?)
      curl << "\n#{obj.url}"
      curl << " \\\n-d \\\n'#{JSON.pretty_generate(hash)}'" if hash
    end

    curl
    rescue
      "Oops. Something went wrong. Make sure all your entries are correct.
      If everything is accurate and you're still having an issue, contact an admin."
    end
  end

  def update_hash(hash, key, val)
    hash.each do |k,v|
      if Hash === v
        update_hash(hash[k], key, val)
      else
        if (hash.key?(key) && key != "")
          if hash[key].class == Integer || hash[key].class == Fixnum
            hash[key] = val.to_i
          elsif hash[key] == true || hash[key] == false
            val.to_s == "true" ? val = true : val = false
            hash[key] = val
          else
            hash[key] = val
          end
        end
      end
    end
  end

  def insert_text_into_url(url, text_to_replace, text_replacing)
    url.gsub(/<#{text_to_replace}>/, text_replacing)
  end

  def get_all_keys(hash)
    hash.map do |k, v|
      Hash === v ? [get_all_keys(v)] : [k]
    end.flatten
  end

  def get_keys_from_url(url)
    url.scan(/<.*?>/)
  end

  def convert_domains(array)
    new_array = Array.new
    array.each { |domain| new_array.push({"domain-name" => domain})}
    new_array = [{"domain-name" => "sonian.net"}] if new_array.empty?
    new_array
  end

  def create_sidenav_sections(map)
    new_map         = Array.new
    services        = Array.new
    subsection_hash = Hash.new

    map.each do |hash_string|
      hash = JSON.parse(hash_string.gsub('=>', ':'))
      services << hash['service']
      new_map << hash
    end

    services.each do |service_name|
      subsection_hash[service_name] = []
      new_map.each do |section|
        if section['service'] == service_name
          subsection_hash[service_name] << section['subsection']
        end
      end
    end

    subsection_hash
  end

  def role_in_params?(role)
    params[:roles].include?(role) rescue false
  end

  def array_param(key, index)
    params[key.to_sym][index] rescue nil
  end

  def load_key_from_session(key)
    session[key] = params[key] if params[key]
    session[key]
  end

  def show_from_session?(key)
    if !params[key] && params["utf8"] == "✓"
      session[key] = false
      false
    elsif session[key]
      true
    elsif !session[key] && params[key]
      session[key] = true
      true
    else
      false
    end
  end

end
