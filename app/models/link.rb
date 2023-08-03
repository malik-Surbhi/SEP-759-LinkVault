class Link < ApplicationRecord
  belongs_to :user
  has_one :like, dependent: :destroy
  accepts_nested_attributes_for :like


  validates :title, presence:  { message: "Title can not be left blank" }
  validates :url, presence:  { message: "URL can not be left blank" }, format: { with: /\Ahttps?:\/\/\S+\z/, message: "Invalid URL format, expected http{s}://xyz.com" }
end
