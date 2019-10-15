require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO !'   |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"
puts "\n\nBien le bonjour aventurier. Indique moi ton sublime nom"
print "> "
user_name = gets.chomp
puts "\n\nEt combien d'ennemies penses-tu pouvoir affronter ?"
nb_ennemies = gets.chomp.to_i
puts "\n\n\n"
my_game = Game.new(user_name, nb_ennemies)

while my_game.is_still_ongoing?
  my_game.show_players
  my_game.new_players_in_sight
  my_game.menu
  print "\n Votre choix : "
  choice = gets.chomp
  puts "\n"
    puts "\n\nnop, mauvaise entrée\n\n"
  my_game.menu_choice(choice)
  puts "\n"
  my_game.enemies_attack
end
my_game.end
