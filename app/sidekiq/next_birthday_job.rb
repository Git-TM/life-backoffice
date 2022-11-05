require 'sidekiq-scheduler'

class NextBirthdayJob < ApplicationJob
  queue_as :default

  def perform(*args)
    person = Person.find(@arguments.first[:arg].id)
    person.incomingbirthday = Date.current.next_year
  end

end

# Je store en BDD le prochain anniversaire
