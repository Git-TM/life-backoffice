class PeopleController < ApplicationController

  def index
    @people = Person.all
    PeopleAnniversaryJob.perform_now
    @array = array
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

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:firstname, :lastname, :dob)
  end
end
