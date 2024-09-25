require_relative 'chooseword.rb'
require_relative 'rules.rb'
require 'colorize'

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
    Rules.new(@guess_array, LIFES)
    letter_guessed = check_input(gets.chomp, letter_repository)
    letter_repository.push(letter_guessed)

    @key_word.each_with_index do |letter, idx|
      if letter_guessed == letter
        @guess_array[idx] = letter_guessed
      end
    end

    @turn_count +=1



    while @turn_count <= LIFES
      puts "\nThe word to find is #{present_word(@guess_array)}"
      puts "You have #{LIFES - @turn_count + 1} tries left"
      puts "Already chosen letter: [#{present_word(letter_repository)}]"
      puts "Please enter a letter:"

      letter_guessed = gets.chomp
      letter_guessed = check_input(letter_guessed, letter_repository) #need to check it's not a duplicate letter
      letter_repository.push(letter_guessed)
      prior_guess_array = @guess_array.dup

      @key_word.each_with_index do |letter, idx|
        if letter_guessed == letter
          @guess_array[idx] = letter_guessed
        end
      end

      if prior_guess_array == @guess_array
          puts "#{letter_guessed} was not in the key word"
          @turn_count += 1
      elsif @guess_array == @key_word
        puts "You found the word! #{@key_word.join('')} was the secret word. Congrats"
        break
      else
        puts "great, #{letter_guessed} was in the key word\n"
        # need to finish when the word is found
      end
    end

    puts "You lost xD" if @turn_count >= LIFES

  end

  # def first_pass
  #   @letter_repository = []
  #   @narrator =  Rules.new
  #   puts @narrator.welcome_message(@key_word)
  #   puts "You will have #{LIFES} turns to figure it out"
  #   puts "Please enter a letter (no special characters)"

  #   letter = gets.chomp
  #   letter = check.input(letter)
  #   @letter_repository.push(letter_guessed) unless letter_repository.include?(letter)
  # end




end


