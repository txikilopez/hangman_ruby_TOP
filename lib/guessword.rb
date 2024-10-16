require_relative 'chooseword'
require_relative 'rules'
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
      @guess_array[idx] = guessed_letter if guessed_letter == letter
    end
  end

  def first_turn
    Rules.new(@guess_array, LIFES) # welcome message
    letter_guessed = check_input(gets.chomp, @letter_repository, @turn_count, @guess_array, @key_word)
    @letter_repository.push(letter_guessed)
    check_guessed_letter(letter_guessed)
    letter_success = (@letter_repository & @guess_array).length > 0
    @turn_count += 1 unless letter_success
    letter_check_message(letter_guessed, letter_success)
  end

  def guessing
    # first turn
    message = first_turn if @turn_count.to_i == 1 && @letter_repository.length == 0

    # subsequent turns
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

    return unless @turn_count >= LIFES

    puts drawing(8)
    puts "You lost, word was '#{present_word(@key_word)}'"
  end
end
