require './tweakSiri'
require './siriObjectGenerator'
require 'open-uri'
require 'soap/wsdlDriver'

@nameFirstTeam = ""
@nameSecondTeam = ""
@scoreFirstTeam = ""
@scoreSecondTeam = ""

#############
# This is a plugin for SiriProxy that will allow you to check the weekends 'german Bundesliga' soccer scores
# Example usage: "Wie hat Stuttgart heute gespielt"
# This Plugin is based on the NHL Plugin from XXXXXXXXXX
#############

class SoccerScores < SiriPlugin


	def score(connection, teamID, teamName)

      @WSDL_URL = "http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL"
      @soap = SOAP::WSDLDriverFactory.new(@WSDL_URL).create_rpc_driver
      gameday = @soap.GetCurrentGroupOrderID(:leagueShortcut=>"bl1")
      int_gameday = gameday.getCurrentGroupOrderIDResult  #gameday.getCurrentGroupOrderID is an Object but an Integer is needed
      response = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>int_spieltag,:leagueShortcut=>"bl1",:leagueSaison=>"2011")

      response.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
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
      }#response.getMatchdataByGroupLeagueSaisonResult.matchdata.each

      if((@scoreFirstTeam == "-1") || (@scoreSecondTeam == "-1"))
        response = "Anscheinend hat " + teamName + " noch nicht gespielt"
      else
        response = "Das Ergebnis des Spiels von " + teamName + " ist: " + @nameFirstTeam + " (" + @scoreFirstTeam + "), " + @nameSecondTeam + " (" + @scoreSecondTeam + ")"
      end

			return connection.inject_object_to_output_stream(generate_siri_utterance(connection.lastRefId, response))

  end #def score(connection, teamID, teamName)

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
			return generate_siri_utterance(connection.lastRefId, score(connection, "87", "Gladbach"))
		end

    if(phrase.match(/Bremen/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "134", "Bremen"))
    end

    if((phrase.match(/Herta/i) || phrase.match(/BSC/i) || phrase.match(/Berlin/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "54", "Berlin"))
		end

    if((phrase.match(/Dortmund/i) || phrase.match(/BVB/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "7", "Dortmund"))
    end

    if(phrase.match(/Leverkusen/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "6", "Leverkusen"))
		end

    if(phrase.match(/Augsburg/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "94", "Augsburg"))
    end

    if((phrase.match(/Bayern/i) || phrase.match(/München/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "40", "Bayern"))
    end

    if((phrase.match(/Kaiserslautern/i) || phrase.match(/lautern/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "76", "Kaiserslautern"))
    end

    if((phrase.match(/Nürnberg/i) || phrase.match(/Club/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "79", "Nürnberg"))
    end

    if(phrase.match(/Hoffenheim/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "123", "Hoffenheim"))
    end

    if((phrase.match(/Hamburg/i) || phrase.match(/HSV/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "100", "Hamburg"))
    end

    if(phrase.match(/Hannover/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "55", "Hannover"))
    end

    if(phrase.match(/Köln/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "65", "Köln"))
    end

    if(phrase.match(/Mainz/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "81", "Mainz"))
    end

    if(phrase.match(/Freiburg/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "112", "Freiburg"))
    end

    if(phrase.match(/Schalke/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "9", "Schalke"))
    end

    if((phrase.match(/Stuttgart/i) || phrase.match(/VFB/i)) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "16", "Stuttgart"))
    end

    if(phrase.match(/Wolfsburg/i) && (phrase.match(/spiel/i) || phrase.match(/gespielt/i)))
			self.plugin_manager.block_rest_of_session_from_server
			connection.inject_object_to_output_stream(object)
			return generate_siri_utterance(connection.lastRefId, score(connection, "131", "Wolfsburg"))
    end

		object
  end
end

