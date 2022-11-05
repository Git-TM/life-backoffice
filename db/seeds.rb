require 'csv'
require 'open-uri'
require 'net/http'
require 'json'

filepath_category = "app/assets/data/Category.csv"
filepath_timentries = 'app/assets/data/timentries.json'
filepath_people = 'app/assets/data/people.csv'
filepath_expense = 'app/assets/data/Expense_app.csv'
csv_options = { col_sep: ',', headers: :first_row, encoding: 'UTF-8' }


# puts "Deleting all"
# Timeentry.delete_all
# Timesubcategory.delete_all
# Categorytime.delete_all
# Person.delete_all
# Peopletype.delete_all
Expense.delete_all
ExpenseCategory.delete_all

# subcategories_array = []

# puts ("----- Grouping all the subcategories -----")
# CSV.foreach(filepath_category, headers: true) do |row|
#   subcategories_array << row[0]
# end

# puts ("----- Create all the categories -----")
# subcategories_array.uniq.each do |subcategory|
#   new_category = Categorytime.create(name: subcategory)
#   new_category.save
# end

# puts ("----- Create all the subcategories -----")
# CSV.foreach(filepath_category, headers: true) do |row|
#   associated = Categorytime.find_by(name: row[0])
#   new_timesubcategory = Timesubcategory.create(name: row[1], categorytime_id: associated.id, shortweek: row[3])
#   new_timesubcategory.save
# end



# puts ("----- Create all the timeentries -----")

# # J'itère et je chéque pour chaque timmentries
# json_file = JSON.parse(File.read(filepath_timentries))
# json_file["timeEntries"].each do |timeentry|

# # initialisaiton des variables
# started_date = Time.parse(timeentry["duration"]["startedAt"])
# ended_date = Time.parse(timeentry["duration"]["stoppedAt"])
# user = User.where(email: "tristanmonteiro97@gmail.com").to_a[0].id

# # Est-ce qu'il y'a un label ?
#   unless timeentry["note"]["tags"].empty?

#   # Si oui je dois regarder si le label est présent dans une subcategory dont le nom est ce nom
#     label_in_subcategory = Timesubcategory.find_by(name: timeentry["note"]["tags"][0]["label"])
#     unless label_in_subcategory.nil?
#       # categorytime = label_in_subcategory.timesubcategory
#         variable = Timeentry.new(start_date: started_date,
#                        end_date: ended_date,
#                        tag: timeentry["note"]["tags"][0]["label"],
#                        timesubcategory_id: Timesubcategory.find_by(name: timeentry["note"]["tags"][0]["label"]).id,
#                        date: started_date,
#                        durationinhour: ((ended_date - started_date) / 3600).round(2),
#                        user_id: user)
#       variable.save
#       p variable
#       p variable.valid?
#     end
#   next
#   end
# end

# # Creating people
# CSV.foreach(filepath_people, headers: true) do |row|
#   unless Peopletype.find(name: row[3]).nil?
#     pt = Peopletype.new(name: row[3])
#     pt.save
#   end
#   pt = Peopletype.find(name: row[3])
#   new_person = Person.new(firstname: row[0], lastname: row[1], dob: row[2])
#   new_person.peopletype = pt
#   new_person.save
# end


# puts ("----- Creating all the peopletypes -----")
# CSV.foreach(filepath_people, headers: true) do |row|
#   p Peopletype.find_or_create_by(name: row[3])
# end


# puts ("----- Create all the people -----")
# CSV.foreach(filepath_people, headers: true) do |row|
#   associated = Peopletype.find_by(name: row[3])
#   new_person = Person.create(firstname: row[0], lastname: row[1], dob: row[2], incomingbirthday: row[4])
#   new_person.peopletype = associated
#   new_person.save
#   p new_person
# end


puts ("----- Creating all the category expenses -----")
CSV.foreach(filepath_expense, headers: true) do |row|
  ExpenseCategory.find_or_create_by(name: row[2])
end


puts ("----- Create all the expenses -----")
CSV.foreach(filepath_expense, headers: true) do |row|
  associated = ExpenseCategory.find_by(name: row[2])
  new_expense = Expense.create(date: row[0], amount: row[1])
  new_expense.expense_category = associated
  new_expense.save
  p new_expense
end
