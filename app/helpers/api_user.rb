class ApiUser < ApiBase

  def ns_test
    required_params([:p1, :p2])
    one = params[:p1]
    two = params[:p2]
    return "#{one} #{two}"
  end

  def ns_create
    required_params([:name, :email, :password])
    return User.create_user(params[:name], params[:email], params[:password])
  end

end