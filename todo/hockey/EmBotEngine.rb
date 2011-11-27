## RUBY SCRIPT
require 'soap/wsdlDriver'

class EmBotEngine

@today = ""
@next = ""
@last = ""


def initialize
@WSDL_URL = "http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL"
@soap = SOAP::WSDLDriverFactory.new(@WSDL_URL).create_rpc_driver
puts "Lade alle Sachen initial in den Cache"
@today_time = Time.now - 3700
@today = today
@next_time = Time.now - 3700
@next = nextGame
@last_time = Time.now - 3700
@last = last
end

#halbfinale = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"3",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
#finale = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"4",:leagueShortcut=>"fem08",:leagueSaison=>"2008")




def today
  #Bei Today alle 2 min neu laden, Spiele laufen ja...
  if (Time.now - @today_time) < 15
    puts "***********************today: CACHE HIT"
    return @today
  else 
    puts "***********************today: CACHE ZU ALT, LADE NEU"
  begin
    Timeout::timeout(10) do
      @today = gettoday
      return @today
    end
  rescue Timeout::Error
      return "Irgendwas dauert hier gerade zu lange... versuch es in 5 Sekunden nochmal :D"
    end
  end
end



    
def gettoday

  vorrunde = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"1",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
  viertelfinale = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"2",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
  laeuftHeute = Array.new
  
  
vorrunde.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
       spieltag =  Date.parse(item.matchDateTime)
        if Date.today.eql?(spieltag)
          if item.pointsTeam1 =="-1" || item.pointsTeam2 == "-1" 
            laeuftHeute << "Vorrunde: " + item.nameTeam1 + "\t|\t" + item.nameTeam2 + (" - noch nicht gestartet")
          else
            laeuftHeute << "Vorrunde: " + item.nameTeam1 + "\t" + item.pointsTeam1 + "|" + item.pointsTeam2 + "\t" + item.nameTeam2 + (" - läuft gerade")
          end
        end
    }
    
viertelfinale.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
           spieltag =  Date.parse(item.matchDateTime)
           if Date.today.eql?(spieltag)
                     if item.pointsTeam1 =="-1" || item.pointsTeam2 == "-1" 
                        laeuftHeute << "Vorrunde: " + item.nameTeam1 + "\t|\t" + item.nameTeam2 + (" - noch nicht gestartet")
                      else
                        laeuftHeute << "Vorrunde: " + item.nameTeam1 + "\t" + item.pointsTeam1 + "|" + item.pointsTeam2 + "\t" + item.nameTeam2 + (" - läuft gerade")
                    end
            end
    }
    
if laeuftHeute.empty?
    @today_time = Time.now 
  return "Heute finden keine Spiele statt"
else
    @today_time = Time.now 
  return laeuftHeute.join("\n")
end

end











def nextGame
  if (Time.now - @next_time) < 1800 #alle 30 min neu laden
        puts "***********************next: CACHE HIT"
  return @next
  else  
            puts "***********************next: CACHE zu alt, lade neu"
begin
Timeout::timeout(10) do
  
     @next = getnextGame
      return @next
    end
  rescue Timeout::Error
      return "Irgendwas dauert hier gerade zu lange... versuch es in 5 Sekunden nochmal :D"
    end
  end
end





def getnextGame
  vorrunde = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"1",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
  viertelfinale = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"2",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
  kommtNoch = Array.new
      
      
vorrunde.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
    if item.matchIsFinished.to_s=="false"  
    spieltag =  Date.parse(item.matchDateTime)
    datum = spieltag.day.to_s + "." + spieltag.month.to_s + "." + spieltag.year.to_s
    kommtNoch  << "Vorrunde: " + datum + "\t" + item.nameTeam1 + "\t|\t" + item.nameTeam2
    end
    }
    
viertelfinale.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
    if item.matchIsFinished.to_s=="false"
    spieltag =  Date.parse(item.matchDateTime)
    datum = spieltag.day.to_s + "." + spieltag.month.to_s + "." + spieltag.year.to_s
    kommtNoch  << "Viertelfinale: " + datum + "\t" + item.nameTeam1 + "\t|\t" + item.nameTeam2
    end
    }

if kommtNoch.empty?
  @next_time = Time.now  
  return "Es kommen keine Spiele auf uns zu bzw es sind noch keine bekannt"
else
  @next_time = Time.now  
  return kommtNoch.join("\n")
end

end











def last
  if (Time.now - @last_time) < 1800 #alle 30 min neu laden
        puts "***********************last: CACHE HIT"
  return @last
  else
            puts "***********************last: CACHE zu alt, lade neu"
  
            begin
            Timeout::timeout(10) do

                 @last = getlast
                  return @last
                end
            rescue Timeout::Error
                  return "Irgendwas dauert hier gerade zu lange... versuch es in 5 Sekunden nochmal :D"
                end
    end
end




def getlast               
  vorrunde = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"1",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
  viertelfinale = @soap.GetMatchdataByGroupLeagueSaison(:groupOrderID=>"2",:leagueShortcut=>"fem08",:leagueSaison=>"2008")
  schonZuEnde = Array.new
      
  vorrunde.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
    if item.matchIsFinished=="true"
    spieltag =  Date.parse(item.matchDateTime)
    datum = spieltag.day.to_s + "." + spieltag.month.to_s + "." + spieltag.year.to_s
    schonZuEnde << "Vorrunde: " + datum + "\t" + item.nameTeam1 + "\t"+ item.pointsTeam1 + "|" + item.pointsTeam2 + "\t" + item.nameTeam2
    end
    }
    
    viertelfinale.getMatchdataByGroupLeagueSaisonResult.matchdata.each{|item|
      if item.matchIsFinished=="true"
        spieltag =  Date.parse(item.matchDateTime)
        datum = spieltag.day.to_s + "." + spieltag.month.to_s + "." + spieltag.year.to_s
          schonZuEnde << "Viertelfinale: " + datum + "\t" + item.nameTeam1 + "\t"+ item.pointsTeam1 + "|" + item.pointsTeam2 + "\t" + item.nameTeam2
        end
      }
      
      
      if schonZuEnde.empty?
          @last_time = Time.now  
        return "Entweder die EM hat noch nicht angefangen oder irgendwas geht hier gerade schief... 0_o"
      else
          @last_time = Time.now  
        return schonZuEnde.join("\n")
      end
end




end