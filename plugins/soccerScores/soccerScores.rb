require './tweakSiri'
require './siriObjectGenerator'
require 'open-uri'
require 'nokogiri'

#############
# This is a plugin for SiriProxy that will allow you to check the weekends 'german bundesliga' soccer scores
# Example usage: "Wie hat Stuttgart heute gespielt"
# This Plugin is based on the NHL Plugin from XXXXXXXXXX
#############

class SoccerScores < SiriPlugin
  @firstTeamName = ""
  @firstTeamScore = ""
  @secondTeamName = ""
  @secondTeamScore = ""

	def score(connection, userTeam)

	  Thread.new {
	    doc = Nokogiri::HTML(open("http://mobil.bundesliga.de/index.php?file=de/index.xhtml"))
      #scores = doc.css(".game_entry")

      #scores.each {
      #  |score|
      #  team_home = score.css(".pic25left")
        #team_guest = score.css(".pic25right") #second array needed

      #  team_home.each {
      #    |teamname|
      #    if(teamname.content.strip == userTeam)
      #      firstTeam = score.css("div:nth-child(1)").first
      #      @firstTeamName = firstTeam.css(".pic25left").first.content.strip
      #      @firstTeamScore = firstTeam.css(".score").first.content.strip  #function needed to convert 2:2 into seperated values
      #      secondTeam = score.css("div:nth-child(1)").first
      #      @secondTeamName = secondTeam.css(".pic25right").first.content.strip
      #      @secondTeamScore = secondTeam.css(".score").first.content.strip
      #      break
      #    end
      # }

        #team_guest.each {
        #  |teamname|
        #  if(teamname.content.strip == userTeam)
        #    firstTeam = score.css("div:nth-child(1)").first
        #    @firstTeamName = firstTeam.css(".pic25left").first.content.strip
        #    @firstTeamScore = firstTeam.css(".score").first.content.strip
        #    secondTeam = score.css("div:nth-child(1)").first
        #    @secondTeamName = secondTeam.css(".pic25right").first.content.strip
        #    @secondTeamScore = secondTeam.css(".score").first.content.strip
        #    break
        #  end
        #}

      #}

      if((@firstTeamName == "") || (@secondTeamName == ""))
        response = "No games involving the " + userTeam + " were found playing tonight"
      else
        response = "The score for the " + userTeam + " game is: " + @firstTeamName + " (" + @firstTeamScore + "), " + @secondTeamName + " (" + @secondTeamScore + ")"
			end
			connection.inject_object_to_output_stream(generate_siri_utterance(connection.lastRefId, response))
    }

		return "Checking on tonight's hockey games "+ userTeam
	end

  def homeScoreParser(score)

  #This Parser is needed to convert the score as sting into 2 integer and add them to the @fistTeamScore and @secondTeamScore

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
			return generate_siri_utterance(connection.lastRefId, score(connection, "WOB"))
    end

		object
	end
end
