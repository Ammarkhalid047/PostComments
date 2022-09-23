class User < ApplicationRecord

  scope :get_status, -> {where(status:'inactive')}
  scope :get_active, -> {where(status:'active')}

  mount_uploader :image, ImageUploader

  #after_create :user_registration_email

  enum role: {admin: 0, owner: 1}
  enum status: {inactive: 0, active: 1}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_one_attached :image
  
  has_many :post,  dependent: :destroy
  has_many :comments , dependent: :destroy
  has_one :address , dependent: :destroy
  accepts_nested_attributes_for :address
end
