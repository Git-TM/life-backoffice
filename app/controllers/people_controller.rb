class PeopleController < ApplicationController

  before_action :todaybirthdays, only: [:index]

  def index
    @people = Person.all
    @upcoming_birthday_people = Person.order(incomingbirthday: :asc).limit(5)
  end

  def show
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.save
    redirect_to people_path
  end

  def edit
  end

  def update
    @person.update(person_params)
    redirect_to person_path(@person)
  end

  def destroy
    @person.destroy
    redirect_to people_path
  end


  def todaybirthdays
    @birthday_people_today = []
    Person.all.each do |per|
      if per.dob.strftime('%m/%d/') == Time.now.strftime('%m/%d/')
        @birthday_people_today << per
      end
    end
    return @birthday_people_today
  end

  private


  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:firstname, :lastname, :dob)
  end
end
