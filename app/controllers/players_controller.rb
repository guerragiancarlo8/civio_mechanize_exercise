class PlayersController < ApplicationController
	def index
		#clean database if not empty
		#Player.delete_all
		agent = Mechanize.new
		#get the page of all the players. We only load the database once
		#this improves performance and avoids unnecessary scraping redundancy
		if Player.all.blank?
			page = agent.get("http://es.soccerway.com/national/spain/primera-division/20152016/regular-season/r31781/players/?ICID=PL_3N_04")
		#get image, goals and minutes from each individual player profile. 
		#we only need numbers from the 2015/2016 season, so that's why we search by index when filling out the @goals and @minutes
			player_links = page.links_with(:href => /^\/players.+\/$/)
			player_links.each do |link|
				page = link.click
				image = page.search(".yui-u img").attr("src")
				goals =  page.search(".goals")[1].text
				minutes =  page.search(".game-minutes")[1].text
				goals_per_minute = ((goals.to_f/minutes.to_f)).round(2).to_s
				#load them into the database so we can do view creation and facilitate sorting
				Player.create(image: image, goals: goals, minutes: minutes, goalsmin: goals_per_minute)
			end
		end
		#if sorting parameters were given, sort by that attribute
		#otherwise, just return the list as was scraped
		if params[:sort].present?
			if params[:sort] == "goles"
				@players = Player.order(goals: :desc)
			elsif params[:sort] == "minutos"
				@players = Player.order(minutes: :desc)
			elsif params[:sort] == "goalsmin"
				@players = Player.order(goalsmin: :desc)
			end
		else
			@players = Player.all
		end
	end
end
