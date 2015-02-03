class User < ActiveRecord::Base

  has_many :characters

  include BCrypt

  validates :email, uniqueness: true

  validates :name, :password_hash, presence: true

  validates :email, presence: true, :format => { :with => /\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}/}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end