require_relative 'chooseword'
require_relative 'rules'
require 'colorize'

class ChooseWord < Rules
  WORDS = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)

  def initialize(shortest_word = 5, longest_word = 12)
    @words_array = WORDS.select do |word|
      word.length >= shortest_word && word.length <= longest_word
    end
  end

  def choose_hangman_word
    picked_word = @words_array.sample
    @picked_word_as_array = picked_word.split('')
  end
end
