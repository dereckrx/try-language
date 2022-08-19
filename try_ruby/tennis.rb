require 'minitest/autorun'

# https://blog.arkency.com/10-lessons-learnt-from-the-ruby-refactoring-kata-tennis-game/
# https://gist.github.com/dm1try/c8808504fbbc69457e7cb89d678e70d0
#
class TennisGame1

  def initialize(player_1_name, player_2_name)
    @player_1_name = player_1_name
    @player_2_name = player_2_name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == "player1"
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    result = ""
    tempScore = 0
    if (@p1points == @p2points)
      result = {
        0 => "Love-All",
        1 => "Fifteen-All",
        2 => "Thirty-All",
      }.fetch(@p1points, "Deuce")
    elsif (@p1points >= 4 or @p2points >= 4)
      minusResult = @p1points - @p2points
      if (minusResult == 1)
        result = "Advantage player1"
      elsif (minusResult == -1)
        result = "Advantage player2"
      elsif (minusResult >= 2)
        result = "Win for player1"
      else
        result = "Win for player2"
      end
    else
      (1...3).each do |i|
        if (i == 1)
          tempScore = @p1points
        else
          result += "-"
          tempScore = @p2points
        end
        result += {
          0 => "Love",
          1 => "Fifteen",
          2 => "Thirty",
          3 => "Forty",
        }[tempScore]
      end
    end
    result
  end
end

class TennisGame2

  SCORE_NAMES = {
    0 => 'Love',
    1 => 'Fifteen',
    2 => 'Thirty',
    3 => 'Forty'
  }.freeze

  WIN_SCORE = 4
  WIN_BY_SCORE = 2

  attr_reader :game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @game = {
      player1 => 0, player2 => 0
    }
  end

  def won_point(player)
    @game[player] += 1
  end

  def score
    if win_score_reached?
      if player_win?
        "Win for #{winning_player}"
      elsif tie_game?
        'Deuce'
      else
        "Advantage #{winning_player}"
      end
    elsif tie_game?
      "#{score_name(player1)}-All"
    else
      "#{score_name(player1)}-#{score_name(player2)}"
    end
  end

  private

  attr_reader :player1, :player2

  def score_name(player)
    SCORE_NAMES.fetch(@game[player])
  end

  def player_win?
    winning_score - losing_score >= WIN_BY_SCORE
  end

  def tie_game?
    winning_score == losing_score
  end

  def win_score_reached?
    winning_score >= WIN_SCORE || losing_score >= WIN_SCORE - 1
  end

  def winning_player
    @game.find do |_, score|
      score == winning_score
    end[0]
  end

  def winning_score
    @game.values.max
  end

  def losing_score
    @game.values.min
  end
end

class TennisGame3

  SCORE_NAMES = {
    0 => 'Love',
    1 => 'Fifteen',
    2 => 'Thirty',
    3 => 'Forty'
  }.freeze

  WIN_SCORE = 4
  WIN_BY_SCORE = 2

  attr_reader :game

  def initialize(player1, player2)
    @game = Game.start(player1, player2)
  end

  def won_point(player)
    @game = @game.score_point(player)
  end

  def score
    if @game.win?
      "Win for #{@game.winning_player}"
    elsif @game.advantage_scoring?
      if @game.tie?
        'Deuce'
      else
        "Advantage #{@game.winning_player}"
      end
    elsif @game.tie?
      "#{SCORE_NAMES[@game.scores(0)]}-All"
    else
      "#{SCORE_NAMES[@game.scores(0)]}-#{SCORE_NAMES[@game.scores(1)]}"
    end
  end

  class Game

    attr_reader :winning_player

    def self.start(player1, player2)
      Game.new(
        player1 => 0,
        player2 => 0
      )
    end

    def initialize(scores)
      @scores = scores
      @winning_score = scores.values.max
      @losing_score = scores.values.min
      @winning_player = @scores.find { |_, score| score == @winning_score }[0]
    end

    def scores(index)
      @scores.values[index]
    end

    def score_point(player)
      Game.new(@scores.merge(player => @scores[player] + 1))
    end

    def win?
      winning_score >= WIN_SCORE && winning_score - losing_score >= WIN_BY_SCORE
    end

    def tie?
      winning_score == losing_score
    end

    def advantage_scoring?
      @scores.values.sum >= WIN_SCORE + WIN_BY_SCORE
    end

    private

    attr_reader :winning_score, :losing_score
  end
end

#-------------------------------------------------
# First to 4, must win by 2
# 3-3 is deuce, next point has advantage
# You must win the advantage, otherwise back to deuce
TEST_CASES = [
  [0, 0, "Love-All", 'player1', 'player2'],
  [1, 1, "Fifteen-All", 'player1', 'player2'],
  [2, 2, "Thirty-All", 'player1', 'player2'],
  [3, 3, "Deuce", 'player1', 'player2'],
  [4, 4, "Deuce", 'player1', 'player2'],

  [1, 0, "Fifteen-Love", 'player1', 'player2'],
  [0, 1, "Love-Fifteen", 'player1', 'player2'],
  [2, 0, "Thirty-Love", 'player1', 'player2'],
  [0, 2, "Love-Thirty", 'player1', 'player2'],
  [3, 0, "Forty-Love", 'player1', 'player2'],
  [0, 3, "Love-Forty", 'player1', 'player2'],
  [4, 0, "Win for player1", 'player1', 'player2'],
  [0, 4, "Win for player2", 'player1', 'player2'],

  [2, 1, "Thirty-Fifteen", 'player1', 'player2'],
  [1, 2, "Fifteen-Thirty", 'player1', 'player2'],
  [3, 1, "Forty-Fifteen", 'player1', 'player2'],
  [1, 3, "Fifteen-Forty", 'player1', 'player2'],
  [4, 1, "Win for player1", 'player1', 'player2'],
  [1, 4, "Win for player2", 'player1', 'player2'],

  [3, 2, "Forty-Thirty", 'player1', 'player2'],
  [2, 3, "Thirty-Forty", 'player1', 'player2'],
  [4, 2, "Win for player1", 'player1', 'player2'],
  [2, 4, "Win for player2", 'player1', 'player2'],

  [4, 3, "Advantage player1", 'player1', 'player2'],
  [3, 4, "Advantage player2", 'player1', 'player2'],
  [5, 4, "Advantage player1", 'player1', 'player2'],
  [4, 5, "Advantage player2", 'player1', 'player2'],
  [15, 14, "Advantage player1", 'player1', 'player2'],
  [14, 15, "Advantage player2", 'player1', 'player2'],

  [6, 4, 'Win for player1', 'player1', 'player2'],
  [4, 6, 'Win for player2', 'player1', 'player2'],
  [16, 14, 'Win for player1', 'player1', 'player2'],
  [14, 16, 'Win for player2', 'player1', 'player2'],

  [6, 4, 'Win for player1', 'player1', 'player2'],
  [4, 6, 'Win for player2', 'player1', 'player2'],
  [6, 5, 'Advantage player1', 'player1', 'player2'],
  [5, 6, 'Advantage player2', 'player1', 'player2']
].freeze

class RubyFunctions < Minitest::Test
  def play_game(tennis_game_class, p1_points, p2_points, p1_name, p2_name)
    game = tennis_game_class.new(p1_name, p2_name)
    (0..[p1_points, p2_points].max).each do |i|
      if i < p1_points
        game.won_point(p1_name)
      end
      if i < p2_points
        game.won_point(p2_name)
      end
    end
    game
  end

  def test_score_game_1
    TEST_CASES.each do |testcase|
      (p1_points, p2_points, score, p1_name, p2_name) = testcase
      game = play_game(TennisGame3, p1_points, p2_points, p1_name, p2_name)
      begin
        actual_score = game.score
      rescue => error
        puts "Game: #{game.game}"
        raise error
      end
      puts "Game: #{game.game}"
      assert_equal(score, actual_score)
    end
  end
end