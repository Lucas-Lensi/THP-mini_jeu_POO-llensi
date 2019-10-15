class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize (user_name, nb_enemies)
    @players_left = nb_enemies
    @enemies_in_sight = Array.new
    @human_player = HumanPlayer.new(user_name)
  end

  def kill_player (player)
    @players_left -= 1
    return @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    return @players_left > 0 && @human_player.life_points > 0
  end

  def show_players
    @human_player.show_state
    @enemies_in_sight.each do |player|
      player.show_state
    end
  end

  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      puts "\n\nTous les joueurs sont déjà en vue\n\n"
    else
      result_dice = rand(1..6)
      if result_dice == 1
        puts "\n\nAucune joueurs supplémentaires n'apparaissent\n\n"
      elsif result_dice == (2..4)
        @enemies_in_sight << Player.new("Enemie#{rand(1000..9999)}")
        puts "\n\nUn nouvel adversaire en vue, a l'attaque !!\n\n"
      else
        @enemies_in_sight << Player.new("Enemie#{rand(1000..9999)}")
        if @enemies_in_sight.length == @players_left
          puts "\n\nUn nouvel adversaire en vue, a l'attaque !!\n\n"
        else
          @enemies_in_sight << Player.new("Enemie#{rand(1000..9999)}")
          puts "\n\n...2 nouveaux joueurs en vue... bonne chance :)"
        end
      end
    end
  end

  def menu
    puts "\n\n--------------------------------------------\n"
    puts "\nQuelle action veux-tu effectuer ?\n"
    puts "a - Chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "\nAttaquer un joueur en vue :"
    @enemies_in_sight.each_with_index do |player, index|
      print "#{index} - "
      player.show_state
    end
  end

  def menu_choice
    str = gets.chomp
    puts "\n"
    if str == "a"
      @human_player.search_weapon
    elsif str == "s"
      @human_player.search_health_pack
    elsif str.to_i == (0..@enemies_in_sight.length)
      @human_player.attacks(@enemies_in_sight[str.to_i])
      @enemies_in_sight[str.to_i].life_points <= 0 ? kill_player(@enemies_in_sight[str.to_i]) : 0
    else
      puts "Nop, pas possible, recommence"
      menu_choice
    end
  end

  def enemies_attack
    @enemies_in_sight.each do |player|
      player.attacks(@human_player)
      puts "\n"
    end
  end

  def end
    puts "\n\nLa partie est finit\n\n"
    if @human_player.life_points> 0
      puts "BRAVO, TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end
end
