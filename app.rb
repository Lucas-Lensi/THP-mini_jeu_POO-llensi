require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player2 = Player.new("José")
player1 = Player.new("Josianne")

puts "ready ? FIGHT"

while player1.life_points > 0 && player2.life_points > 0
  puts "\n---------------------------------------------------\n"
  puts "\nVoici l'état de chaque joueurs :"
  player1.show_state
  player2.show_state
  puts "\nPassons à la phase d'attaque :"
  player1.attacks(player2)
  player2.life_points <= 0 ? break : 0
  player2.attacks(player1)
end
