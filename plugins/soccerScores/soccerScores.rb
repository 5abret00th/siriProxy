require './tweakSiri'
require './siriObjectGenerator'
require 'open-uri'
require 'nokogiri'

  @firstTeamName = "test"
  @firstTeamScore = "test"
  @secondTeamName = "test"
  @secondTeamScore = "test"

#############
# This is a plugin for SiriProxy that will allow you to check the weekends 'german bundesliga' soccer scores
# Example usage: "Wie hat Stuttgart heute gespielt"
# This Plugin is based on the NHL Plugin from XXXXXXXXXX
#############

class SoccerScores < SiriPlugin


	def score(connection, userTeam)

	  Thread.new {
      puts "test"
	    doc = Nokogiri::HTML(open("http://www.nhl.com/ice/m_scores.htm"))
      scores = doc.css(".gmDisplay")

      scores.each {
        |score|
        team = score.css(".blkcolor")
        team.each {
          |teamname|
          if(teamname.content.strip.downcase == userTeam.downcase)
            firstTeam = score.css("tr:nth-child(2)").first
            @firstTeamName = firstTeam.css(".blkcolor").first.content.strip
            @firstTeamScore = firstTeam.css("td:nth-child(2)").first.content.strip
            secondTeam = score.css("tr:nth-child(3)").first
            @secondTeamName = secondTeam.css(".blkcolor").first.content.strip
            @secondTeamScore = secondTeam.css("td:nth-child(2)").first.content.strip
            break
          end
        }
      }
      if((@firstTeamName == "") || (@secondTeamName == ""))
        response = "No games involving the " + userTeam + " were found playing tonight"
      else
        response = "The score for the " + userTeam + " game is: " + @firstTeamName + " (" + @firstTeamScore + "), " + @secondTeamName + " (" + @secondTeamScore + ")"
			end
			@firstTeamName = ""
			@secondTeamName = ""
			say response

			request_completed
		}

	  return "Checking on tonight's hockey games"
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
			return generate_siri_utterance(connection.lastRefId, score(connection, "BVB"))
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
