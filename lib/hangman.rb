class Rules
  def present_word(word_array)
    word_array.join(' ')
  end

  def welcome_message(hidden_word)
    puts "Welcome to Hangman"
    puts "You will have XX turns to guess the secret word #{present_word(hidden_word)}"
  end

  def check_input(character)
    character = character.downcase
    while character.length != 1 || character.class != String || (character =~ /[a-z]/) != 0
      puts "Please enter a valid letter:"
      character = gets.chomp
    end
    character.downcase
  end

end 

class ChooseWord < Rules
  WORDS = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)

  def initialize(shortest_word= 5, longest_word = 12)
    @words_array = WORDS.select do |word|
    word.length >= shortest_word && word.length <= longest_word
    end
  end

  def choose_hangman_word
    picked_word = @words_array.sample
    @picked_word_as_array = picked_word.split('')
  end
end

class GuessWord < Rules
  LIFES = 7
  attr_reader :key_word, :turn_count
  attr_accessor :guess_array
  MAXTURNS = 7

  def initialize(key_word)
    @turn_count = 1
    @key_word = key_word
    @guess_array = Array.new(@key_word.length, "_")
    guessing
  end

  def guessing
    letter_repository = []

    while @turn_count <= LIFES
      puts "\nYou have #{(LIFES - @turn_count) + 1} tries left"
      puts "The word is: #{present_word(@guess_array)}"
      puts "Please enter a letter (no special characters)"
      
      letter_guessed = gets.chomp
      letter_guessed = check_input(letter_guessed) #need to check it's not a duplicate letter
      letter_repository.push(letter_guessed) unless letter_repository.include?(letter_guessed)
      prior_guess_array = @guess_array.dup

      @key_word.each_with_index do |letter, idx|
        if letter_guessed == letter
          @guess_array[idx] = letter_guessed
        end
      end

      if prior_guess_array == @guess_array
          puts "#{letter_guessed} was not in the key word\n"
          @turn_count += 1
      elsif @guess_array == @key_word
        puts "You found the word! #{@key_word.join('')} was the secret word. Congrats"
        break
      else
        puts "great, #{letter_guessed} was in the key word\n"
        # need to finish when the word is found
      end
    end
  end
end


word = ChooseWord.new.choose_hangman_word
GuessWord.new(word)