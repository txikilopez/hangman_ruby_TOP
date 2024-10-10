require_relative 'chooseword.rb'
require_relative 'rules.rb'
require 'colorize'

class GuessWord < Rules
  LIFES = 7
  attr_reader :key_word, :turn_count
  attr_accessor :guess_array
  MAXTURNS = 7

  def initialize(keyword, turn_count, guess_array_input, letter_repository_input)
    @turn_count = turn_count.to_i
    @key_word = keyword
    @letter_repository = letter_repository_input
    @guess_array = guess_array_input
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
    #first turn
    if @turn_count.to_i == 1
      Rules.new(@guess_array, LIFES) #welcome message
      letter_guessed = check_input(gets.chomp, @letter_repository, @turn_count, @guess_array, @key_word) 
      @letter_repository.push(letter_guessed)
      check_guessed_letter(letter_guessed)
      letter_success = (@letter_repository & @guess_array).length > 0
      @turn_count +=1 unless letter_success
      message = letter_check_message(letter_guessed, letter_success)
    end 

    #subsequent turns
    while @turn_count <= LIFES

      turn_message(@guess_array, LIFES, @turn_count, @letter_repository, message, @key_word)

      letter_guessed = check_input(gets.chomp, @letter_repository, @turn_count, @guess_array, @key_word) 
      @letter_repository.push(letter_guessed)
      
      prior_guess_array = @guess_array.dup

      check_guessed_letter(letter_guessed)

      if prior_guess_array == @guess_array
        message = letter_check_message(letter_guessed, false)
          @turn_count += 1
      elsif @guess_array == @key_word
        puts `clear`
        puts "WINNER!! '#{@key_word.join('')}' was the word. Congrats"
        break
      else
        message = letter_check_message(letter_guessed, true)
      end
    end

    if @turn_count >= LIFES
      puts drawing(8)
      puts "You lost, word was '#{present_word(@key_word)}'" 

    end

  end
end


