require './tweakSiri'
require './siriObjectGenerator'
require 'open-uri'
require 'soap/wsdlDriver'
#require 'nokogiri'

@nameFirstTeam = ""
@nameSecondTeam = ""
@scoreFirstTeam = ""
@scoreSecondTeam = ""

#############
# This is a plugin for SiriProxy that will allow you to check the weekends 'german bundesliga' soccer scores
# Example usage: "Wie hat Stuttgart heute gespielt"
# This Plugin is based on the NHL Plugin from XXXXXXXXXX
#############

class SoccerScores < SiriPlugin


	def score(connection, teamID)

      @WSDL_URL = "http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL"
      @soap = SOAP::WSDLDriverFactory.new(@WSDL_URL).create_rpc_driver
      puts "Lade alle Sachen initial in den Cache"
      spieltag = @soap.GetCurrentGroupOrderID(:leagueShortcut=>"bl1")
      puts "groupID geladen"
      puts spieltag.getCurrentGroupOrderIDResult
      int_spieltag = spieltag.getCurrentGroupOrderIDResult
      puts int_spieltag
      response = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>int_spieltag,:leagueShortcut=>"bl1",:leagueSaison=>"2011")

      response.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
        puts item.nameTeam1
        puts item.idTeam1
        puts item.nameTeam2
        puts item.idTeam2
        if item.idTeam1 == teamID
          @nameFirstTeam = item.nameTeam1
          @nameSecondTeam = item.nameTeam2
          @scoreFirstTeam = item.pointsTeam1
          @scoreSecondTeam = item.pointsTeam2
          break
        elsif item.idTeam2 == teamID
          @nameFirstTeam = item.nameTeam1
          @nameSecondTeam = item.nameTeam2
          @scoreFirstTeam = item.pointsTeam1
          @scoreSecondTeam = item.pointsTeam2
          break
        end
        #  break
        #end

        #GetCurrentGroupOrderIDResult
      }

      if((@firstTeamName == "") || (@secondTeamName == ""))
        response = "Kein Spiel der Mannschaft " + teamID + " gefunden"
      else
        response = "Das Ergebnis des Spiels zwischen " + teamID + " ist: " + @nameFirstTeam + " (" + @scoreFirstTeam + "), " + @nameSecondTeam + " (" + @scoreSecondTeam + ")"
			end
			connection.inject_object_to_output_stream(generate_siri_utterance(connection.lastRefId, response))


                  #wsdl
      #@response =  @soap.wsdl.get_matchdata_by_group_league_saison(:groupOrderID=>"1",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
      #@response = @soap.request :get_avail_sports

      #puts "######################## "
      #puts @response

      #@response.getavailsportsresponse.sport.each {|test|
      #   puts test.sportsName
      #  }
        #@soap.version = 2
        #@soap.body = 9998



      puts "testtest"
      ausgabe = "test"
      connection.inject_object_to_output_stream(generate_siri_utterance(connection.lastRefId, ausgabe))


    return "pruefe bundesligaspiele"

  end

	#plusgin implementations:
	def object_from_guzzoni(object, connection)

		object
	end


	#Don't forget to return the object!
	def object_from_client(object, connection)


		object
	end


	def unknown_command(object, connection, command)


		object
	end

	def speech_recognized(object, connection, phrase)
    if(phrase.match(/Gladbach/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "BMG"))
		end

    if(phrase.match(/Bremen/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "BRE"))
    end

    if((phrase.match(/Herta/i) || phrase.match(/BSC/i) || phrase.match(/Berlin/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "BSC"))
		end

    if((phrase.match(/Dortmund/i) || phrase.match(/BVB/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "7"))
    end

    if(phrase.match(/Leverkusen/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "B04"))
		end

    if(phrase.match(/Augsburg/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "FCA"))
    end

    if((phrase.match(/Bayern/i) || phrase.match(/München/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "FCB"))
    end

    if((phrase.match(/Kaiserslautern/i) || phrase.match(/lautern/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "FCK"))
    end

    if((phrase.match(/Nürnberg/i) || phrase.match(/Club/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "FCN"))
    end

    if(phrase.match(/Hoffenheim/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "HOF"))
    end

    if((phrase.match(/Hamburg/i) || phrase.match(/HSV/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "HSV"))
    end

    if(phrase.match(/Hannover/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "H96"))
    end

    if(phrase.match(/Köln/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "KOE"))
    end

    if(phrase.match(/Mainz/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "M05"))
    end

    if(phrase.match(/Frankfurth/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "SCF"))
    end

    if(phrase.match(/Schalke/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "S04"))
    end

    if((phrase.match(/Stuttgart/i) || phrase.match(/VFB/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "VFB"))
    end

    if(phrase.match(/Wolfsburg/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "Stars"))
    end

		object
	end
end
