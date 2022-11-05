require 'sidekiq-scheduler'

class PeopleAnniversaryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Person.all.each do |per|
      if per.dob.strftime('%m/%d/') == Time.now.strftime('%m/%d/')
        NextBirthdayJob.perform_in(1.day, arg: per)
      end
    end
  end

end
