class Album < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :all_tags, presence: true
  validates :title, :description, :length => { :minimum => 2 }
  validates :cover_image, presence: true
  

  has_one_attached :cover_image
  has_many_attached :images

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :user

  def self.tagged_with(name)
    Tag.find_by_name!(name: name).albums
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end
  

end
