class SuspensionsController < ApplicationController

  def fetch_suspensions
    sql_query = "select * from nfl_suspensions"
    @suspensions = ActiveRecord::Base.connection.execute(sql_query)

    @suspensions = @suspensions.map do |hash|
      suspension = Suspension.new
      suspension.name = hash["name"]
      suspension.team = hash["team"]
      suspension.games = hash["games"]
      suspension.category = hash["category"]
      suspension.description = hash["description"]
      suspension.year = hash["year"]
      suspension.source = hash["source"]
      suspension
    end
  end

  def index
    @suspensions = fetch_suspensions.sort_by(&:name)
    if params[:qs].present?
      (@suspensions = @suspensions.select{ |s| s.name.include? params[:qs]) ||
      (@suspensions = @suspensions.select{ |s| s.category.include? params[:qs]) ||
      (@suspensions = @suspensions.select{ |s| s.description.include? params[:qs]) ||
      (@suspensions = @suspensions.select{ |s| s.year.include? params[:qs])
    end
  end
  end
  def decadegraph
    fetch_suspensions
  end
end
