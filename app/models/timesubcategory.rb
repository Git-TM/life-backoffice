class Timesubcategory < ApplicationRecord
  has_many :timeentries
  has_one :categorytime
end
