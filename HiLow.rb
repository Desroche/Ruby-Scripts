# Initiate the game
def play_choice
  puts "Do you want to play HiLow? (Yes/No)"
  choice = gets.chomp.downcase

  if choice == "yes"
    play_game
  elsif choice == "no"
    puts "Thank you for playing!"
  else
    puts "Invalid choice. Please try again."
    play_choice
  end
end


# Player submitting their choices
def guess_number(secret_number)
  puts "Guess a number:"
  guess = gets.chomp.to_i

  if guess == secret_number
    puts "You guessed correctly!"
  elsif guess < secret_number
    puts "Guess higher."
    guess_number(secret_number)
  elsif guess == 111
    puts "Game Stopped"
  else guess > secret_number
    puts "Guess lower."
    guess_number(secret_number)
  end
end

#Player selects a maximum/highest number for the game
def play_game
  puts "Enter a maximum number for the HiLow Game: (During Play: guess 111 to quit)"
  max_number = gets.chomp.to_i

  secret_number = rand(1..max_number)

  while true
    guess_number(secret_number)
    puts "Do you want to play again? (Yes/No)"
    choice = gets.chomp.downcase

    if choice == "yes"
      play_game
      break
    elsif choice == "no"
      puts "Thank you for playing!"
      break
    elsif choice != "yes"
      puts "Invalid choice. Exiting the game."
      break
    end
  end
end

play_choice


