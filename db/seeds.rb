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

# J'itère et je chéque pour chaque timmentries
json_file = JSON.parse(File.read(filepath_timentries))
json_file["timeEntries"].each do |timeentry|

# initialisaiton des variables
started_date = Time.parse(timeentry["duration"]["startedAt"])
ended_date = Time.parse(timeentry["duration"]["stoppedAt"])
user = User.where(email: "tristanmonteiro97@gmail.com").to_a[0].id

# Est-ce qu'il y'a un label ?
  unless timeentry["note"]["tags"].empty?

  # Si oui je dois regarder si le label est présent dans une subcategory dont le nom est ce nom
    label_in_subcategory = Timesubcategory.find_by(name: timeentry["note"]["tags"][0]["label"])
    unless label_in_subcategory.nil?
      categorytime = label_in_subcategory.categorytime
        variable = Timeentry.new(start_date: started_date,
                       end_date: ended_date,
                       tag: timeentry["note"]["tags"][0]["label"],
                       categorytime_id: Timesubcategory.find_by(name: timeentry["note"]["tags"][0]["label"]).categorytime_id,
                       date: started_date,
                       durationinhour: ((ended_date - started_date) / 3600).round(2),
                       user_id: user)
      variable.categorytime = categorytime
      variable.save
      p variable
      p variable.valid?

# categorytime = Categorytime.new(first_name: "Gregory", last_name: "House")
# categorytime.save

# timeentry = Timeentry.new(first_name: "Allison", last_name: "Cameron")
# timeentry.categorytime = categorytime
# timeentry.save



      # Timeentry.create(start_date: started_date,
      #                  end_date: ended_date,
      #                  tag: timeentry["note"]["tags"][0]["label"],
      #                  categorytime_id: Timesubcategory.find_by(name: timeentry["note"]["tags"][0]["label"]).categorytime_id,
      #                  date: started_date,
      #                  durationinhour: ((ended_date - started_date) / 3600).round(2),
      #                  user_id: user)
      # variable.categorytimes = label_in_subcategory
      # variable.save!
      # p variable.valid?
    end
  # Si non, je next.
  next
  end
end

# Creating people
CSV.foreach(filepath_people, headers: true) do |row|
  pt = Peopletype.new(name: row[3])
  pt.save
  pe = Person.create!(firstname: row[0], lastname: row[1], dob: row[2], peopletype_id: pt.id)
end
