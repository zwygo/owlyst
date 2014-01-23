class User < ActiveRecord::Base
  def self.authenticate(email, password)
    user = find_by_email(email)

    return user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    return nil
  end

  def self.create_user(name, email, password)
    password_salt = BCrypt::Engine.generate_salt()
    password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    User.create(
      :name => name,
      :email => email,
      :password_salt => password_salt,
      :password_hash => password_hash
    )
  end
end