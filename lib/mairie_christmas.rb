require 'nokogiri'
require 'pry'
require 'rubocop'
require 'open-uri'
require 'rubygems'      

def get_town_halls_emails
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))        # <---- Appel de l'URL necessaire grace a la gem Nokogiri 

  townhalls = Array.new(0)    # <---- Création de notre array de maire

  page.css('//a[@class=lientxt]/@href').each.with_index do |href, index|                 # <--- Sélecteur css
    complete_url = "http://annuaire-des-mairies.com/#{href}"                       # <--- @href permet de changer de mairie 
    townhall = Nokogiri::HTML(URI.open(complete_url))                              # <--- Défini la variable townhall pour décrire le chemin a suivre en fonction des mairies
    
    city = townhall.css("h1")[1].text.split(" - ")[0].to_s               # <---- Défini la variable city, selectionne le deuxieme h1 de la page, et enlève " - 95450"
    
    begin
    email = townhall.css("tr.txt-primary")[3].css("td")[1].text.to_s            # <---- Exception en cas d'erreur, marche a suivre, indicateur [x] x = séléctionner la ligne voulu
    rescue  => e
    email = "Inconnu"                                                      # <--- Si jamais l'email n'est pas trouvé, au lieu de crée un erreur de programme, affiche inconnu
    end
    
    townhalls[index] = { city => email }                       # <---- Ajoute la key a la Value de notre array
    
    puts "Mairie de #{city} - Email: #{email}"              # <---- Return de notre Array selon nos variable défini

  end

  return townhalls
end

get_town_halls_emails()               # <--- Appel de la méthode crée