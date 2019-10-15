require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def welcome_menu
  puts "-------------------------------------------------"
  puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO !'   |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
  puts "\n\nBien le bonjour aventurier. Indique moi ton sublime nom"
  print "> "
  user_name = gets.chomp
  puts "\n\n\n"
  user = HumanPlayer.new(user_name)
  @array_player = Array.new
  @array_player << player1 = Player.new("Josianne")
  @array_player << player2 = Player.new("José")
  fight_loop(user, player1, player2)
end

def bot_attack (user, player1, player2)
  if player1.life_points > 0 || player2.life_points > 0
    puts "\n\nLes autres joueurs attaquent, attention !\n\n"
  end
  @array_player.each do |play|
    if play.life_points > 0
      play.attacks(user)
      print "\n"
    end
  end
end

def fight_loop(user, player1, player2)
  while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
    user.show_state
    puts "\n\n--------------------------------------------\n"
    puts "\nQuelle action veux-tu effectuer ?\n"
    puts "a - Chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "\nAttaquer un joueur en vue :"
    print "0 - "
    player1.show_state
    print "1 - "
    player2.show_state
    print "\n Votre choix : "
    choice = gets.chomp
    puts "\n-----------------------------------------------\n\n"
    if choice == "a"
      user.search_weapon
    elsif choice == "s"
      user.search_health_pack
    elsif choice == "0"
      user.attacks(player1)
    elsif choice == "1"
      user.attacks(player2)
    else
      puts "Nop, t'as le choix entre a, s, 0, 1. Alors fais ton choix. Merci."
    end
    bot_attack(user, player1, player2)
  end
  end_game (user)
end

def end_game (user)
  puts "\n\nLa partie est finit\n\n"
  if user.life_points> 0
    puts "BRAVO, TU AS GAGNE !"
  else
    puts "Loser ! Tu as perdu !"
  end
end

welcome_menu
