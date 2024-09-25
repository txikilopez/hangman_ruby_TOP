class Rules

  def initialize(hidden_word, lifes)
    welcome_message(hidden_word, lifes)
  end


  def present_word(word_array)
    word_array.join(' ')
  end

  def welcome_message(hidden_word, lifes)
    puts "Welcome to Hangman"
    puts "You will have #{lifes} turns to guess the secret word #{present_word(hidden_word)}"
    puts "Please enter a letter:"
  end

  def check_input(character, letter_repository)
    character = character.downcase
    while character.length != 1 || character.class != String || (character =~ /[a-z]/) != 0 || letter_repository.include?(character)
      puts "Please enter a valid letter:"
      character = gets.chomp.downcase
    end
    character.downcase
  end



end 
