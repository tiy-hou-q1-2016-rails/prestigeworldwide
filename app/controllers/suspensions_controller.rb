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
    fetch_suspensions
  end



  def decadegraph
    fetch_suspensions
  end
end
