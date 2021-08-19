class Category < ApplicationRecord
  has_many :microposts
  validates :name_pl, presence: true
  validates :name_en, presence: true
  validates :name_it, presence: true
  validates :name_cn, presence: true

end
