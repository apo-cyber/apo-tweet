class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true, length: {maximum:140}

  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def self.ransackable_attributes(auth_object = nil)
    %w[title content created_at]
  end

  def self.ransackable_assosiations(auth_object = nil)
    []
  end

end
