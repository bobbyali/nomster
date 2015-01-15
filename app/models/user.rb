require 'securerandom'
require 'digest'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :places
  has_many :comments

  after_initialize :generate_api_keys

  def valid_token?(t, token)
    int = self.private_key + t
    # validate timestamp is within x seconds, and possibly check for timezone
    hashed_int = Digest::SHA256.hexdigest(int)
    hashed_int == token
  end

  def self.user_for(public_key)
    u = User.where(:public_key => public_key).first
  end

  private

    def generate_api_keys
      self.private_key ||= SecureRandom.hex(10)
      self.public_key ||= self.email.gsub(/@|\./, '-')
    end


end
