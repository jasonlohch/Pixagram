class Post < ApplicationRecord
  validates :image, presence: true
  validates :description, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :image, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.search(search)
  	search_condition = "%#{search}%"
  	if search
  		where('description ILIKE ? OR location ILIKE?', search_condition, search_condition).order('id DESC')
    else
  	 	order('id DESC')
    end
  end

end