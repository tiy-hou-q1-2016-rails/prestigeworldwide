class SuspensionsController < ApplicationController

  def fetch_suspensions
    sql_query = "select * from nfl_suspensions"
    @suspensions = ActiveRecord::Base.connection.execute(sql_query)

    @suspensions = @suspensions.map do |hash|
      suspension = Suspension.new
      suspension.name = hash["name"]
      suspension.team = hash["team"]
      suspension.games = hash["games"].to_i
      suspension.category = hash["category"]
      suspension.description = hash["description"]
      suspension.year = hash["year"].to_i
      suspension.source = hash["source"]
      suspension
    end
  end

  def index
    fetch_suspensions
  end

  def decadegraph
    @suspensions = fetch_suspensions

    @fourties = []
    @fifties = []
    @sixties = []
    @seventies = []
    @eighties = []
    @nineties = []
    @aughts = []
    @teens = []
    @null_year = []

    @suspensions.map do |suspension|
      if suspension.year.to_i >= 1940 && suspension.year.to_i < 1950
        @fourties << suspension
      elsif suspension.year.to_i >= 1950 && suspension.year.to_i < 1960
        @fifties << suspension
      elsif suspension.year.to_i >= 1960 && suspension.year.to_i < 1970
        @sixties << suspension
      elsif suspension.year.to_i >= 1970 && suspension.year.to_i < 1980
        @seventies << suspension
      elsif suspension.year.to_i >= 1980 && suspension.year.to_i < 1990
        @eighties << suspension
      elsif suspension.year.to_i >= 1990 && suspension.year.to_i < 2000
        @nineties << suspension
      elsif suspension.year.to_i >= 2000 && suspension.year.to_i < 2010
        @aughts << suspension
      elsif suspension.year.to_i >= 2010 && suspension.year.to_i < 2020
        @teens << suspension
      else
        @null_year << suspension
      end
    end

    @fourties
    @fifties
    @sixties
    @seventies
    @eighties
    @nineties
    @aughts
    @teens

    @peds = []
    @substance_abuse = []
    @personal_conduct = []
    @game_violence = []

    @suspensions.map do |suspension|
      if suspension.category.downcase.include? "peds"
        @peds << suspension
      elsif suspension.category.downcase.include? "substance"
        @substance_abuse << suspension
      elsif suspension.category.downcase.include? "conduct"
        @personal_conduct << suspension
      else
        @game_violence << suspension
      end
    end

    @peds
    @substance_abuse
    @personal_conduct
    @game_violence


    @peds_games = []
    @substance_abuse_games = []
    @personal_conduct_games = []
    @game_violence_games = []

    @suspensions.map do |suspension|
      if suspension.category.downcase.include? "peds"
        @peds_games << suspension.games.to_i
      elsif suspension.category.downcase.include? "substance"
        @substance_abuse_games << suspension.games.to_i
      elsif suspension.category.downcase.include? "conduct"
        @personal_conduct_games << suspension.games.to_i
      else
        @game_violence_games << suspension.games.to_i
      end
    end
    @peds_games
    @substance_abuse_games
    @personal_conduct_games
    @game_violence_games

    @peds_avg = (@peds_games.inject(0, :+).to_f)/@peds_games.count.to_f
    @substance_abuse_avg = (@substance_abuse_games.inject(0, :+).to_f)/@substance_abuse_games.count.to_f
    @personal_conduct_avg = (@personal_conduct_games.inject(0, :+).to_f)/@personal_conduct_games.count.to_f
    @game_violence_avg = (@game_violence_games.inject(0, :+).to_f)/@game_violence_games.count.to_f

  end

end
