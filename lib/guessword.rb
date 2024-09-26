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

  def check_guessed_letter(guessed_letter)
    @key_word.each_with_index do |letter, idx|
      if guessed_letter == letter
        @guess_array[idx] = guessed_letter
      end
    end
  end

  def guessing
    letter_repository = []
    Rules.new(@guess_array, LIFES)
    letter_guessed = check_input(gets.chomp, letter_repository)
    letter_repository.push(letter_guessed)

    check_guessed_letter(letter_guessed)

    @turn_count +=1 unless (letter_repository & @guess_array).length > 0

    while @turn_count <= LIFES
      puts `clear`
      puts "\nThe word to find is '#{present_word(@guess_array)}'"
      puts "You have #{LIFES - @turn_count + 1} tries left"
      puts "Already chosen letter: [#{present_word(letter_repository - @guess_array)}]"
      puts "Please enter a letter:"

      letter_guessed = gets.chomp
      letter_guessed = check_input(letter_guessed, letter_repository) 
      letter_repository.push(letter_guessed)
      prior_guess_array = @guess_array.dup

      check_guessed_letter(letter_guessed)

      if prior_guess_array == @guess_array
          puts "#{letter_guessed} was not in the key word"
          @turn_count += 1
      elsif @guess_array == @key_word
        puts "You found the word! '#{@key_word.join('')}' was the secret word. Congrats"
        break
      else
        puts "\ngreat, #{letter_guessed} was in the key word\n"
      end
    end

    puts "You lost xD, keyword was '#{present_word(@key_word)}'" if @turn_count >= LIFES

  end
end


