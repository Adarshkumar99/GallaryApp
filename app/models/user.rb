class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :albums, dependent: :destroy

  validates :name, presence: true
  validates :dob, presence: true
  validates :gender, presence: true
end