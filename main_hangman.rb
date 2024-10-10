require_relative 'lib/chooseword'
require_relative 'lib/guessword'
require_relative 'lib/rules'
require 'yaml'

puts 'Do you want to start a new game (1) or continue your last saved one (2)'
ans = gets.chomp

if ans.to_i == 2
  data = YAML.load_file('saved_file.yaml')
  GuessWord.new(data[:keyword], data[:turn_count].to_i, data[:guess_array], data[:letter_repo])
else
  word = ChooseWord.new.choose_hangman_word
  GuessWord.new(word, 1, Array.new(word.length, '_'), [])
end
