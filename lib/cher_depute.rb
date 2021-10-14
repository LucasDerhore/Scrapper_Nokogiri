require 'nokogiri'                                                                                        # <---- Gem utilisée
require 'pry'
require 'rubocop'
require 'open-uri'
require 'rubygems'  

def get_the_deputies_infos
  page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/tableau"))            # <----  Selectionne l'url de la page voulu
  
  deputes_array = Array.new(0)                                                                            # <----  Création de notre array deputes                  
  
  page.css('//tr/td/a').each.with_index do |link, index|                                                  # <----  Selectionne la partie du site voulu (avec le chemin)
                           
      complete_url = "https://www2.assemblee-nationale.fr#{link["href"].to_s}"                            # <----  Selectionne le nom complet des député(e)s      
      deputes = Nokogiri::HTML(URI.open(complete_url))                                                    # <----  Indique le chemin pour la deuxieme page
       
  
      begin                                                                                               
        full_name = deputes.css('h1').text.split(" ")                                                     # <---- Selectionne l'endroit exacte du full_name
        last_name = full_name[2].to_s                                                                     # <---- Selectionne l'endroit exacte du nom de famille
        first_name = full_name[1].to_s                                                                    # <---- Selectionne l'endroit exacte du prenom
      rescue => e                                                                                         
        first_name = "Prénom inconnu"                                                                     # <---- Indique ce message en cas d'erreur du code first_name
        last_name = "Nom inconnu"                                                                         # <---- Indique ce message en cas d'erreur du code last_name
      end

      begin
        email = deputes.css('.deputes-liste-attributs li')[5].text.split(" : ")[1].to_s                   # <---- Selection l'endroi exact de email
      rescue => e
        email = "email Inconnu"                                                                           # <---- Indique ce message en cas d'erreur du code email                                
      end

      deputes_array[index] = {                                                                            # <---- Hash, keys - value
        "first_name" => first_name,
        "last_name" => last_name,
        "email" => email
      }
        
      
       puts "Député #{last_name} #{first_name} - Email : #{email}"                                       # <---- Execute avec puts "..............."

    end

  return deputes_array                                                                                   
end
    
get_the_deputies_infos()                                                                                 # <--- Appel de la méthode crée
      
 #100Code
 
#          __888888888888888888888888
#________8888::: 8888888888888888888888888
#_______8888 :::::: 8888888888888888888888888888
#______88 ::::::::: 888::: 8888888888888888888888888
#_____88888888:::: 8 ::::::::::: 888888888888888888888
#____888 8:: 888888 :::::::::::::::::: 888888888888888888
#::::: ::::: ____88 88888888 888888888888888888 m ::::::::::
#____888888888888888888:: M ::::::::::: 8888888888888888
#____88888888888888888888 :::::::::::: M888888888888888
#____8888888888888888888888 ::::::::: M8888888888888888
#____ 8888888888888888888888 ::::::: M888888888888888888
#____8888888888888888:: 88888 :::::: M88888888888888888888
#___88888888888888888::: 88888 ::::: M888888888888888888888
#__ 88888888888888888::: 88888:::: M, o * M * o;:: 8888888888888
#__88888888888888888::: 8888 ::::: M ::::::::::::: 8888888888888
#_ 88888888888888888:::: 88 :::::: M :;::::::::::::: 888888888888
#_8888888888888888888::: 8 :::::: Maaa ::::::::::: M888888888888
#_88_ 8888888888:: 88:::: 8:::: M ::::::::::::::::::: 8888888888888
#88_88888888888::: 8 M ::::::::: ::::::::::;::::::::: 88:888888888 88
#8_8888888888888 M ::::::::::::: aaaaaaa" ":::::: 8w888888888888
#_88888888888: 888 M :::::::::: :::::"    ":::::::::: M8i8888888888888
#8888888888:::: 88 ::::::::: M88 ::::::::::::::::: M88z88888888888888
#8888888888 ::::: 8 ::::::::: M88888 :::::::::: MM888! 88888888888888
#888888888 ::::: 8 ::::::::: M8888888MAmmmAMVMM888 * 88888888
#888888 M ::::::::::::::: M888888888 ::::::: MM88888888888888
#8888_ M :::::::::::::: M88888888888 :::::: MM888888888888888
#888 _M ::::::::::::: M8888888888888M ::::: mM888888888888888
#_888_M :::::::::::: M8888: 888888888888:::: m:: Mm88888 888888
#_ 88_M :::::::::::: :::::: 8888:88888888888888888 Mm8_ 88888
#_ 88_M :::::::::: 8888M:: 88888:: 888888888888 ::::::: Mm88888
#_ 8 _MM :::::::: 8888M::: 8888 ::::: 888888888888 :::::::: MM8
#___ 8M ::::::: 8888M 888 ::::: ::::::: 88::: 8888888 :::::::: Mm
#___88MM ::::: 8888M ::::::: :::::::: 88 8 888888 :::::::: ::::: M M
#__ 8888M ::::: 888MM :::::::: 8 ::::::::::: M:::: 8888:::: M:::: M
#__88888M ::::: 88: M ::::::::::: :::::::::: 8 M::: 8888 :::::: M: M
#_ 88 888MM::: 888: M M ::::::::::::::::::::::: 8888 ::::::::::
#_ 88 888MM::: 888: M M ::::::::::::::::::::::: 8888 ::::::::::::: M:
#_ 8 88888M::: 88:: ::::::::::::::::::::::: M MM: 88 :::::::::::::: :: M
#__ 88888M::: 88:: M 88 M ::::::::::::* *::::::::: 88 ::::::::::::::: ::: M
#__888888M::: 88:: M :::::: M ::::::::: 88 @ @ 88:: 88 ::::::::::::::::::: M
#__888888MM:: 88:: MM :::::: 88 @ @ 88 M ::::::::: 8 :::::::::::::::::::::* 8
#__88888 M::: 8: MM ::::::::::::* 88 :::::::::::::::::: M *:::::::: :::: 88 @ @
#__ 8888 _M :::::: MM ::::::::::::::::::::::: MM :::::::::::::::: ::::::: 88 @ @
#M ___888_ ::::::: MM ::::::::::::::::::::: MM: :::::::::::::::: M :::::::::* 8
#___888__M :::::: MMM ::::::::::::::::::: MM::: MM :::::::::::::::::: ::::: M
#___88 __M :::::::: MMMM MMMM ::::::::::: ::::: :::::::::::::::::::: MM MM
#____88__M :::::::::: ::::::::: Mmmmmmmmmmmm MMM MMM :::::::::::::
#____ 88__M :::::::::::::: MMMMMMM ::::::::::::::::: MMMMMMMMMM
#_____88 _8M ::::::::::::::::::::::::::::::::::::::::::::::: MMMMMM
#_____8 _88M ::::::::::::::::::::::::::::: M :::::: M ::::::::::: ::: MM
#_______ 888m :::::::::::::::::::::::::: MM :::::: MM MM :::::::::
#_______88888M ::::::::::::::::::::: MMM ::::::: mM :::::: MM
#_______888888M ::::::::::::::::: MMM ::::::::::: M :::::::: M
#______88 88888M :::::::::::: MMM :::::::::::::: M :::::: M
#______8_88888M ::::::::::: MM ::::::::::::::: M ::::::: M:
#_______ 88888: M :::::::::: M :::::::::::::::: M ::::::: MM
#_______888888M ::::::::: M :::::::::::::::::::::::::: M: M
#_______888888M ::::::: M ::::::::::::::::::::::: M: M
#:::::::::::::::::mad:@::::::::::::::::: _______88888M M: M
#______ 88888M :::::::::::::::::mad:@@:::::::::::::::: M::: M
#::::::::::::::::::mad:@:::::::::::::::::: ______88888M M:::: M
#_____ 88888M ::::::: ::::::: m ::::::::::::::::: Mm M M :::::
#_____8888M :::::::: M ::::::::::::::::::::::: MM ::::::: ::::::: M M
#____ 8888M :::::::: :::::::: M :::::::::::::::::::::: MMM M ::::::: M
#____888_M ::::::: :::::::::::::::::::: Mm MMM ::::::::: ::::::::: M M
#___8888_MM ::::: Mm ::::::::::::::::::: MMMM ::::::::: m::: m:::: M
#__ 888__M ::::::: M :::::::::::::::::::: :::::::::::: MMM M:::: mm: :: M
#_8888__MM ::::::::::::::::::::::::::: MM ::::::::::::: mm::: MM::: : M:
#______ M :::::::::::::::::::::::::::::: M :::::::::::::: mm:: : MM::: Mm
#______MM :::::::: M :::::::::::::::::::::::::::::::::::: M::: : MM::: MM
#_____ M :::::::::::::::::::::::::::::::::::: ::::::::::: M :: M::: M::: MM
#_____MM :::::::::: M :::::::::::::::: M ::::::::::::::::::::: M:: M::: MM
#_____m ::::::::::::: M88 :::::::::::: M ::::::::::::::::::::: MM ::: MMM
#_____m :::::::::::::: 8888888888M :::::::::::::::::::::: MM:::: MM
#M ____ :::::::::::::::: 88888888M :::::::::::::::::::::::: M ::::: MM
#M ____ ::::::::::::::::: 888888M ::::::::::::::::::::::::: M:::: : MM
#_____m ::::::::::::::::: 88888M ::::::::::::::::::::::::: M:::: MM
#_____m ::::::::::::::::::: 88 M :::::::::::::::::::::::::::: M :: MM
#::::::::::::::::::::: _____m M ::::::::::::::::::::::::::: : MMM
#:::::::::::::::::: _____MM M :::::::::::::::::::::::::::::: MMM
#:::::::::::::::::: ______M M :::::::::::::::::::::::::::::: MMM
#______MM :::::::::::::::: M :::::::::::::::::::::::::::::: MMM
#______ M :::::::::::::::: M :::::::::::::::::::::::::::::: MMM
#_______MM ::::::::::::: M ::::::::::::::::::::::::::::: MMM
#_______M :::::::::::::: M ::::::::::::::::::::::::::::: MMM
#_______ MM :::::::::::: M :::::::::::::::::::::::::::: MMM
#________M ::::::::::: M :::::::::::::::::::::::::::::: MMM
#_________MM ::::::: M :::::::::::::::::::::::::: MMM
#_________ MM :::::: M :::::::::::::::::::::::: MMM
#_________ MM ::::: M ::::::::::::::::::::::: MMM
#__________MM:::: MMM ::::::::::::::::::::: M
#__________MM::: MMM ::::::::::::::::::::: M
#__________ MM:: MMM :::::::::::::::::::: M
#__________ MM: MMM ::::::::::::::::::: M
# MMM :::::::::::::::::: ___________MMM
#MMM :::::::::::::::::: ___________MM
#__________ M :::::::::::::::::::: MMM
#MMM ::::::::::::::::::: __________MM
#MMM ::::::::::::::::::: __________MM
#__________MM :::::::: M :::::::::: MMM:
#__________mMM ::::: MM :::::::: MMMM
#__________ MMM MMM :::::::::::::::: M
#___________mMM :::::: ::::::: M MM:: M
#___________MM ::::: :::::: MMMM M: M
#___________ MM MMM ::::: ::::::: M: M
#___________ MM ::::: MM :::::::: M::: M
#____________MM:::: MM MM :::::::::::
#____________MM:::: MM ::::::::::::: M:
#____________MM ::::: M ::::::::::::::: M
#____________MMM M ::::::::::::::::::::::
#____________ MMM ::::::::::::::::::::: M:
#____________ MMM ::::::::::::::::::::: M:
#_____________MMM M ::::::::::::::::::::::
#_____________MMM :::::::::::::::::::: Mm
#_____________ MM ::::::::::::::::::::: MM
#_____________ MMM MM :::::::::::::::::::
#_____________ MMM MM :::::::::::::::::::
#_____________ MMM MM ::::::::::::::::::
#_____________ MMM MM ::::::::::::::::::
#MMM ::::::::::::::::: ______________MM
#______________MMM :::::::::::::::: MM
#______________MMM ::::::::::::::: MM
#______________MMM :::::::::::::: MM
#______________ MM MM ::::::::::::::
#______________ MM MM :::::::::::::
#______________ MM MM :::::::::::::
#______________ MMM MM :::::::::::
#______________ MMM MM ::::::::::
#_______________MM ::::::::::: MM
#_______________MMM ::::::::: MM
#_______________MMM ::::::::: MM
#_______________ MM MM :::::::::
#_______________ MMM MM :::::::
#_______________ MMM MM :::::::
#________________MM :::::::: MM
#________________MM :::::::: MM
#________________ MM MM :::::::
#________________ MM :::::: MM:
#________________ MM :::::: M: M
#________________ MM :::::: M: M
#________________: M M :::::::::::
#________________M: M M ::::::::::
#M _______________::: M M :::::::::
#________________: M M :::::::::::
#________________M: M M ::::::::::
#M _______________::: M M :::::::::
#_______________M:::: M M :::::::::
#______________ M ::::: :::::::::: M M
#______________M :::::: MM ::::::::: M
#______________M ::::::: M M :::::::::::
#______________M ;:;:::: M M :::::::::::
#______________M: :;::: M ::::::::::: M M
#______________MM: M: m:: M ::::::::;: M
#______________ MM: m:: MM ::::::::;:; M
#_______________MM:: M :::::::;: MMM: M
#_______________MMMM MM ::::: m: m: M
#___________________MM M :::::::: MM
#___________________ MM MM ::::::
#____________________MM:: MM

      