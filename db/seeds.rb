require 'csv'
require 'open-uri'
require 'net/http'
require 'json'

filepath_category = "app/assets/Category.csv"
filepath_timentries = 'app/assets/timentries.json'
filepath_people = 'app/assets/people.csv'
csv_options = { col_sep: ',', headers: :first_row, encoding: 'UTF-8' }


puts "Deleting all"
Timeentry.delete_all
Timesubcategory.delete_all
Categorytime.delete_all

subcategories_array = []

puts ("----- Grouping all the subcategories -----")
CSV.foreach(filepath_category, headers: true) do |row|
  subcategories_array << row[0]
end

puts ("----- Create all the categories -----")
subcategories_array.uniq.each do |subcategory|
  new_category = Categorytime.create(name: subcategory)
  new_category.save
end

puts ("----- Create all the subcategories -----")
CSV.foreach(filepath_category, headers: true) do |row|
  associated = Categorytime.find_by(name: row[0])
  new_timesubcategory = Timesubcategory.create(name: row[1], categorytime_id: associated.id, shortweek: row[3])
  new_timesubcategory.save
end



puts ("----- Create all the timeentries -----")
json_file = JSON.parse(File.read(filepath_timentries))
# p json_file["timeEntries"]
json_file["timeEntries"].each do |timentry|
  start_date = DateTime.parse(timentry["duration"]["startedAt"])
  end_date = DateTime.parse(timentry["duration"]["stoppedAt"])
  timesubcategory = Timesubcategory.where(name: timentry["note"]["tags"][0]["label"]).to_a[0].categorytime_id || 0
  user = User.where(email: "tristanmonteiro97@gmail.com").to_a[0].id
  p timesubcategory
  p user
  unless timentry["note"]["tags"].empty?
    variable = Timeentry.new(start_date: start_date,
                    end_date: end_date,
                    tag: timentry["note"]["tags"][0]["label"],
                    categorytime_id: timesubcategory,
                    user_id: user)
    variable.save
    next
  end
end


# Creating people

# Creating people
CSV.foreach(filepath_people, headers: true) do |row|
  pt = Peopletype.new(name: row[3])
  pt.save
  pe = Person.create!(firstname: row[0], lastname: row[1], dob: row[2], peopletype_id: pt.id)
end
