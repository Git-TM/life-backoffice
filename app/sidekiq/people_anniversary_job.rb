require 'sidekiq-scheduler'

class PeopleAnniversaryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    date = Time.now.strftime('%m/%d/')
    array = []
    people = Person.all
    people.each do |per|
      if per.dob.strftime('%m/%d/') == date
        array << per
      end
    end
    return array
  end

end
