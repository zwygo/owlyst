class ApiController < ApplicationController

  API_CLASSES = [ApiList]

  def call
    req = request.raw_post
    speed = 0
    sess = nil
    ##'{method:"user.status", params:{email:"renarsg@gmail.com", pass:"labais"}}'
    begin
      req_obj = ActiveSupport::JSON.decode(req)
      raise Hell.new("Bad request") if req_obj.blank? || req_obj.class != Hash
      raise Hell.new("Method missing") unless req_obj.keys.include?('method')
      params = req_obj['params'] || {}
      for key in params.keys
        params[key.to_sym] = params[key]
      end
      mm = req_obj['method'].split('.')
      raise Hell.new("Method must be in form class.method") unless mm.length == 2
      class_name = mm[0]
      method = "ns_#{mm[1]}"
      class_class = nil
      for c in API_CLASSES
        if c.to_s == "Api#{class_name.capitalize}"
          class_class = c
        end
      end
      raise Hell.new("Api class not found") if class_class.nil?
      c = class_class.new
      c.params = params
      c.request = request
      method = c.method(method.to_sym)
      @result = method.call
      ret = {
        "aid" => "",
        "result" => @result,
        "error" => nil
      }
      respond_to do |format|
        format.html
        format.json { render :json => ret.to_json }
      end
    rescue Exception => e
      @result = nil
      @error = e.message
      ret = {
        "aid" => "",
        "error" => @error,
        "result" => nil
      }
      respond_to do |format|
        format.html
        format.json { render :json => ret.to_json }
      end
    end
  end

end
