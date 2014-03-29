class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates  :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}
  validates :phone,  length: {is: 10}, allow_blank: true

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def  two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_phone
    # Get your Account Sid and Auth Token from twilio.com/user/account
    account_sid = 'AC3c5a2f84053ad8fcf3495a7a79509cfe'
    auth_token = '9bfa93784a99020d230137b8cd36c9ca'
    errors = []
    client = Twilio::REST::Client.new account_sid, auth_token
    begin
      msg = "Please enter #{self.pin} to login."
      client.account.messages.create(body: msg, to: self.phone, from: "+15029473801")
    rescue Twilio::REST::RequestError
      errors << $!.message
    end
    errors
  end

end
