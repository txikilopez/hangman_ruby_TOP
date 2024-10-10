require_relative 'drawing.rb'
require 'yaml'

class Rules
  include DrawHangman

  def initialize(hidden_word, lifes)
    welcome_message(hidden_word, lifes)
  end

  def present_word(word_array)
    word_array.join(' ')
  end

  def welcome_message(hidden_word, lifes)
    puts `clear`
    puts 'Welcome to Hangman'
    puts "You will have #{lifes} turns to guess a secret word."
    puts "The word to find is: #{present_word(hidden_word)}"
    puts drawing(1)
    puts "\nPlease enter a letter:"       
  end

  def check_input(character, letter_repository, turn_count, guess_array, keyword)
    character = character.downcase
    if character == 'save'
      puts 'Saving game and exiting...'
      saved_info = to_yaml(guess_array, turn_count, letter_repository, keyword)
      File.write('saved_file.yaml',saved_info)
      exit
    end

    while character.length != 1 || (character =~ /[a-z]/) != 0 || letter_repository.include?(character) #|| character.class != String 
      if character == 'save'
        puts 'Saving game and exiting...'
        saved_info = to_yaml(guess_array, turn_count, letter_repository, keyword)
        File.write('saved_file.yaml',saved_info)
        exit
      end
      puts 'Please enter a valid letter:'
      character = gets.chomp.downcase
    end
    character.downcase
  end

  def turn_message(guess_array, lifes, turn_count, letter_repo, message, keyword)
    puts `clear`
    puts 'Welcome to Hangman'
    puts drawing(turn_count)
    puts message
    puts "The word to find is '#{present_word(guess_array)}'"
    turns_taken = letter_repo.length + (guess_array & keyword).length
    puts "\nYou have #{lifes - turn_count + 1} lives left. You've guessed #{turns_taken} times"
    puts "Already chosen letters: [#{present_word(letter_repo - guess_array)}]"
    puts 'Please enter a letter, or type "save" to save & exit your game:'
    
  end

  def letter_check_message(letter_guessed, check_letter)
    check_letter ? "Great! #{letter_guessed} is included" : "Womp womp, #{letter_guessed} is not included"
  end

  def to_yaml(guess_array, turn_count, letter_repo, keyword)
    YAML.dump ({
      keyword: keyword,
      guess_array: guess_array,
      turn_count: turn_count,
      letter_repo: letter_repo
    })
  end

  def self.from_yaml(string)
    data = YAML.load(string)
    data
  end

end 