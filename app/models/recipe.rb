class Recipe < ApplicationRecord
  has_attached_file :image, styles: { medium: "400x400" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, :description, :image, presence: true

  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy

  belongs_to :user

  # accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  # accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :ingredients,
                           reject_if: proc { |attributes| attributes['name'].blank? },
                           allow_destroy: true
  accepts_nested_attributes_for :directions,
                           reject_if: proc { |attributes| attributes['step'].blank? },
                           allow_destroy: true
end
