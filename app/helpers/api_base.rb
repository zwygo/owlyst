require "net/http"
class ApiBase
  attr_accessor :params
  attr_accessor :request

  def required_params(names)
    missing = []
    for name in names
      missing.push(name) if params[name].blank?
    end
    raise Hell.new("Missing parameters: #{missing.join(', ')}") if missing.length > 0
  end

end
