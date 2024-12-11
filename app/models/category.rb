class Category < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 60, 40 ]
    attachable.variant :medium, resize_to_limit: [ 512, 512 ]
  end

  has_many :products
end
