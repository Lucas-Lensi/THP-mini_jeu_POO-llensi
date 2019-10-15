class Player

  attr_accessor :name, :life_points

  def initialize (player_name)
    @name = player_name
    @life_points = 10
  end

  def show_state
    if @life_points > 0
      puts "#{@name} a #{@life_points} point de vie"
    else
      puts "#{@name} est mort"
    end

  end

  def gets_damage(damage_life)
    @life_points -= damage_life
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
    end
  end

  def attacks(player_attacked)
    puts "#{@name} attaque #{player_attacked.name}"
    damage = compute_damage
    puts "#{@name} inflige #{damage} points de dégats à #{player_attacked.name}"
    player_attacked.gets_damage(compute_damage)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level, :life

  def initialize (player_name)
    super(player_name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} a #{@life_points} point de vie et une arme de niveau #{@weapon_level}\n\n"
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    result_dice = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{result_dice}"
    if result_dice > @weapon_level
      @weapon_level = result_dice
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    result_dice = rand(1..6)
    if result_dice == 1
      puts "Tu n'as rien trouvé... "
    elsif result_dice == (2..5)
      @life_points + 50 > 100 ? @life_points = 100 : @life_points += 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      @life_points + 80 > 100 ? @life_points = 100 : @life_points += 80
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end
end
