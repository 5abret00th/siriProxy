#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'savon'

 # create a client for your SOAP service
      soap = Savon::Client.new("http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL")
      puts soap.wsdl.soap_actions
      puts "#############################"
      puts soap
      #doc1 = Nokogiri::XML(open(soap.request(:get_avail_sports)))
      #scores1 = doc1.xml("Sport")
      #scores1.each {
      #  |score1|
      #  team1 = score1.xml(".sportsName")
      #  team1.each {
      #    |teamname1|
      #    if(teamname1.content.strip == userTeam)
      #      puts "jippy"
      #    end
      #  }
      #}


      response = soap.wsdl.request(:get_match_by_match_id=>"9998")

      puts "testtest"

      puts response