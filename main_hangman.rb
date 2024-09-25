require_relative 'lib/chooseword'
require_relative 'lib/guessword'
require_relative 'lib/rules'

word = ChooseWord.new.choose_hangman_word

GuessWord.new(word)