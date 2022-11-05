class ExpensesController < ApplicationController

  def dashboard
    init
    @allexpensescategories = ExpenseCategory.all
  end

  private

  def init
    if params[:search].nil?
      @allexpenses = Expense.all
      @sum_jour = 7
    else
      @allexpenses = Expense.where(date: (params[:search][:start_date].to_s..params[:search][:end_date].to_s))
      @sum_jour = params[:search][:end_date].to_date - params[:search][:start_date].to_date
      @allname = ExpenseCategory.pluck(:name).uniq
    end
  end
end
