class User < ApplicationRecord
            # Include default devise modules.
            devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :validatable
            # include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_secure_password
  has_one_attached :profile_photo
  after_create :assign_default_role

  has_many :links, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :likes

  validates :username, presence: true, uniqueness: { message: "Username '%{value}' is already taken" }
  validates :email, presence: true, uniqueness:  { message: "Email '%{value}' is already taken" }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format, expected abc@def.com" }
  validates :password, presence:  { message: "Password cannot be left blank" }

  validate :password_match

  def password_match
    return if password == password_confirmation
    errors.add(:password_confirmation, "Password and Password Confirmation don't match")
  end

  def likes?(link)
    likes.exists?(link: link)
  end

  def assign_default_role
    role = Role.find_by(name: "user")
    user_roles.create(role: role) if role && user_roles.empty?
  end

  def admin?
    user_roles.exists?(role: Role.find_by(name: 'admin'))
  end

end
