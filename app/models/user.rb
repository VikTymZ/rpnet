class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :post

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
