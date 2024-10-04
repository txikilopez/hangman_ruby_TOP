class Rules

  def initialize(hidden_word, lifes)
    welcome_message(hidden_word, lifes)
  end

  def present_word(word_array)
    word_array.join(' ')
  end

  def welcome_message(hidden_word, lifes)
    puts `clear`
    puts "Welcome to Hangman\n"
    puts "You will have #{lifes} turns to guess a secret word."
    puts "The word to find is: #{present_word(hidden_word)}"
    puts "\nPlease enter a letter:"
  end

  def check_input(character, letter_repository)
    character = character.downcase
    while character.length != 1 || character.class != String || (character =~ /[a-z]/) != 0 || letter_repository.include?(character)
      puts "Please enter a valid letter:"
      character = gets.chomp.downcase
    end
    character.downcase
  end

  def turn_message(guess_array, lifes, turn_count, letter_repo, message)
    puts `clear`
    puts 'Welcome to Hangman'
    puts message
    puts "The word to find is '#{present_word(guess_array)}'"
    puts "\nYou have #{lifes - turn_count + 1} tries left"
    puts "Already chosen letters: [#{present_word(letter_repo - guess_array)}]"
    puts "Please enter a letter:"
  end

  def letter_check_message(letter_guessed, check_letter)
    check_letter  ? "Great! #{letter_guessed} is included" : "Womp womp, #{letter_guessed} is not included"
  end

end 