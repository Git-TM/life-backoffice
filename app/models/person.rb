class Person < ApplicationRecord
  belongs_to :peopletype
  scope :category_best, -> { joins(:peopletype).where('peopletypes.name LIKE ?',  "%best%")}
  scope :category_ami, -> { joins(:peopletype).where('peopletypes.name LIKE ?',  "%best%")}
  scope :incoming_birthdays, -> { where('dob LIKE ?',  "%best%").first(5)}
end
