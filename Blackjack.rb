# Generate Deck of Cards
def generate_deck 
  deck = []
  suits = ['♠', '♥', '♦', '♣']
  values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

  suits.each do |suit|
    values.each do |value|
      deck << [value, suit]
    end
  end
  deck
end

# Shuffle Deck
def shuffle_deck(deck)
  deck.shuffle!
end

# Identify Cards
def identify_card(card)
  value, suit = card
  "#{value} #{suit}"
end

# Label cards
def label_cards(hand)
  labeled_hand = []
  hand.each { |card| labeled_hand << identify_card(card) }
  labeled_hand
end

# Display hand totals
def display_hand(hand)
  labeled_hand = label_cards(hand)
  total = calculate_hand_value(hand)

  # Spacing for Interface display
  puts " "
  puts "Hand: #{labeled_hand.join(', ')}"
  puts "Total: #{total}"
  puts " "

end

# Determine winner
def determine_winner(player_hand, dealer_hand)
  player_value = calculate_hand_value(player_hand)
  dealer_value = calculate_hand_value(dealer_hand)

  if player_value > 21
    :player_busted
  elsif dealer_value > 21
    :dealer_busted
  elsif player_value > dealer_value
    :player_wins
  elsif dealer_value > player_value
    :dealer_wins
  else
    :tie
  end
end

# Check for Blackjack
def blackjack?(hand)
  calculate_hand_value(hand) == 21
end

# Check for busts
def busted?(hand)
  calculate_hand_value(hand) > 21
end

# Pkay game
def play_game
  player_wins = 0
  dealer_wins = 0
  ties = 0

  while true
    deck = generate_deck
    shuffle_deck(deck)

    if deck.length < 4
      puts "Not enough cards in the deck. Game over."
      break
    end

    player_hand = [deck.pop, deck.pop]
    dealer_hand = [deck.pop, deck.pop]

    display_hand(player_hand)
    display_hand([dealer_hand[0], '??'])

    # Player turn
    while true
      if blackjack?(player_hand)
        puts "Congratulations! You got Blackjack!"
        break
      elsif busted?(player_hand)
        puts "Sorry, you busted"
        break
      end

      print "Do you want to hit, stay or double? (h/s/d): "
      choice = gets.chomp.downcase

      if choice == 'h' # Hit
        player_hand << deck.pop
        display_hand(player_hand)
      elsif choice == 's' # Stay
        break
      elsif choice == 'd' # Double
        player_hand << deck.pop
        display_hand(player_hand)
        break
      else
        puts "Invalid choice. Please enter 'h' or 's' or 'd'."
      end
    end

    # Dealer turn
    display_hand(dealer_hand)
    while calculate_hand_value(dealer_hand) < 17
      dealer_hand << deck.pop
      display_hand(dealer_hand)
    end

    # Determine winner
    result = determine_winner(player_hand, dealer_hand)

    case result
    when :player_busted
      puts "Sorry, you busted. Dealer wins!"
      dealer_wins += 1
    when :dealer_busted
      puts "Dealer busted. You win!"
      player_wins += 1
    when :player_wins
      puts "Congratulations! You win!"
      player_wins += 1
    when :dealer_wins
      puts "Sorry, the dealer wins."
      dealer_wins += 1
    when :tie
      puts "It's a tie!"
      ties += 1
    end

    puts "Player Wins: #{player_wins} | Dealer Wins: #{dealer_wins} | Ties: #{ties}"

    print "Do you want to play again? (y/n): "
    choice = gets.chomp.downcase

    break if choice == 'n'
  end
end

# Calculate hand total
def calculate_hand_value(hand)
  total_value = 0
  number_of_aces = 0

  hand.each do |card|
    value, _ = card
    if value == 'A'
      total_value += 11
      number_of_aces += 1
    elsif value.to_i == 0
      total_value += 10
    else
      total_value += value.to_i
    end
  end

  # Check A total
  while total_value > 21 && number_of_aces > 0
    total_value -= 10
    number_of_aces -= 1
  end

  total_value
end

# Start the game
play_game


   
