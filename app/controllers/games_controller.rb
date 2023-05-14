require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = []
    10.times { @grid << ("A".."Z").to_a.sample }
    @grid
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dico = JSON.parse(URI.open(url).read)
    dico["found"]
  end

  def letter_in_grid?
    @word.chars.all? { |letter| @grid.count(letter) >= @word.count(letter) }
  end

  def score
    @word = params[:word].upcase!
    # Comment initialiser @grid ???
    # @grid = new
    @grid = params[:grid].gsub(/\s+/, "").chars
    @result = display_result
  end


  private

  def display_result
    if letter_in_grid?
      if english_word?
        calculate_score
        "Well done! Your score is #{@score}"
      else
        "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      "Sorry but #{@word} can't be built out of #{@grid.join(", ")}"
    end
  end

  def calculate_score
    # initialiser variable d'instance
    @score = session[:score] || 0
    @score += @word.length
    session[:score] = @score
  end

end
