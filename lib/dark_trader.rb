require 'nokogiri'
require 'pry'
require 'rubocop'
require 'open-uri'
require 'rubygems'      



def get_currencies
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))    #  <------     Selectionne l'url de la page voulu 

  cryptos = Array.new(0) # Création d'un tableau

  

  page.css(".cmc-table-row").each.with_index do |line, index|    # <-----   Selectionne la partie du site voulu (les cryptos avec toute leurs informations) + ne garde que la partie demandé 
    
    crypto_name = line.css(".cmc-table__cell--sort-by__name").text    # <----  Selectionne le nom des cryptos pour chaque lignes
    crypto_price = line.css(".cmc-table__cell--sort-by__price").text.gsub("$", "").gsub(",", "").to_f  # <---- Selectionne la valeur de chaque cryptos + remplace l'élément non voulu (gsub)
    
    #Rangez les cryptos dans un Hash ou le nom de la crypto contient le prix
    cryptos[index] = { crypto_name => crypto_price }

    #L'affichage dans le terminal (Array commence par 0 donc index+1) 
    puts "Rang n°#{index+1} - #{crypto_name} : #{crypto_price} $"

  end

  return cryptos
  
end

get_currencies()    # <---- Appel la méthode crée 