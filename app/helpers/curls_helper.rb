module CurlsHelper

  def create_curl_text(obj, params)
    begin
      hash = JSON.parse(obj.data)

      params.each_pair do |key,val|
        if val != ""
          obj.url = insert_text_into_url(obj.url, key.to_s, val) unless val.is_a? Array
          update_hash(hash, key, val)
        end
      end

    curl = "
curl -X#{obj.method} \\
#{obj.headers} \\
#{obj.url} \\
-d \\
'#{JSON.pretty_generate(hash)}'"
    # rescue
    #   ""
    end
  end

  def update_hash(hash, key, val)
    hash.each do |k,v|
      if Hash === v
        update_hash(hash[k], key, val)
      else
        hash[key] = val if (hash.key?(key) && key != "")
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

  def get_url_from_keys(url)
    url.scan(/<\w+>/)
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
end
