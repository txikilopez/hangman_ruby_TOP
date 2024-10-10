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
    puts 'Welcome to Hangman\n'
    puts "You will have #{lifes} turns to guess a secret word."
    puts "The word to find is: #{present_word(hidden_word)}"
    puts drawing(1)
    puts "\nPlease enter a letter:"       
  end

  def check_input(character, letter_repository)
    character = character.downcase
    while character.length != 1 || character.class != String || (character =~ /[a-z]/) != 0 || letter_repository.include?(character)
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
    puts "\nYou have #{lifes - turn_count + 1} tries left"
    puts "Already chosen letters: [#{present_word(letter_repo - guess_array)}]"
    puts 'Do you want to save (1) or continue playing (2)?'
    ans = gets.chomp
    if ans.to_i == 1
      puts 'Saving game and exiting...'
      saved_info = to_yaml(guess_array, turn_count, letter_repo, keyword)
      File.write('saved_file.yaml',saved_info)
      exit
    else
      puts 'Please enter a letter:'
    end
    
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