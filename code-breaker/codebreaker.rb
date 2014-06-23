module Codebreaker
  class Game
    ScoreData = Struct.new(:user, :attempts, :result)

    attr_reader :score, :user_name, :is_started

    def initialize
      @secret_code = []
      @score = []
      @user_name = ''
      @max_attempts = 10
      @is_started = false
    end

    def start(user_name)
      @attempts = 0
      @user_name = user_name
      @is_started = true
      generate
    end

    def finish(finish_message)
      curr_score = ScoreData.new
      curr_score.user = @user_name
      curr_score.attempts = @attempts
      curr_score.result = finish_message
      @score << curr_score

      @user_name = ''
      @secret_code.clear
      @is_started = false
    end

    def match_guess(*guess)
      if !@is_started
        return 'You need to start the game!'
      end

      plus = ''; minus = ''; idxs = []
      guess.each_index do |i|

        if guess[i] == @secret_code[i]
          plus += '+'
          idxs << @secret_code[i]
        elsif @secret_code.include?(guess[i]) && !idxs.include?(guess[i])
          minus += '-'
        end
      end

      @attempts += 1
      result = plus + minus

      if result == '++++'
        self.finish('You win!')
      elsif @attempts == @max_attempts
        self.finish('You loose')
      end
      result
    end

    def get_hint
      @secret_code[rand(0..3)]
    end

    def get_last_score
      @score[@score.length-1]
    end

    private

    def generate
      4.times { |i| @secret_code[i] = rand(1..6) }
    end
  end
end