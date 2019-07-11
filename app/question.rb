class Question < ActiveRecord::Base
        has_many :users_questions
        has_many :users, through: :users_questions

          def self.give_user_questions(user)
            current_score = 0
            questions = Question.all.shuffle
              puts ""
              puts "START GAME"
                  questions.each do |question|
                    question.question.gsub!("&quot;" , '"')
                    question.question.gsub!("&#039;" , "'")
                    puts "==========================================================================="
                    puts ""
                    puts question.question
                    puts ""
                    puts ""
                    puts ""
                    puts  "Answer 'true' or 'false'. Enter 'EXIT' to quit"  
                    answer = gets.chomp.downcase
                      while answer != "true" && answer != "false" && answer != "exit" do
                        puts "Please input 'true' or 'false'"
                        answer = gets.chomp.downcase
                      end
                      if answer.casecmp(question.correct_answer) == 0
                        puts "Correct!"
                        current_score += 1
                        question_info = UsersQuestions.find_or_create_by(question_id: question.id, user_id: user.id)
                        question_info.got_right = 1
                        question_info.save
                        user.save
                          if current_score > user.streak_high_score
                            puts "NEW HIGH SCORE OF #{current_score}!!!!"
                            user.streak_high_score = current_score
                          else
                            puts  "Your Score is: #{current_score}"
                            puts ""
                          end
                      elsif
                        answer == "exit"
                        puts  "Your Score Was: #{current_score}"
                        user.last_score = current_score
                        user.save
                        UserInterface.user_homescreen(user)
                        break
                      else
                        puts ""
                puts "STREAK OVER!"
                puts ""
                puts "Your Score Was: #{current_score}"
                        case current_score
                        when 0..13
                          puts ""
                          puts "Go study!"
                        when 14..27
                          puts ""
                          puts "Meh! You can do better"
                        when 28...40
                          puts ""
                          puts "You're ok... but keep trying"
                        when 41..50
                          puts ""
                          puts "Ok, I know you've played this 10 times!"
                        end
                        user.last_score = current_score
                        question_info = UsersQuestions.find_or_create_by(question_id: question.id, user_id: user.id)
                        question_info.got_right = 0
                        question_info.save
                        user.save
                            self.return_screen(user)
                        break
                      end
                    end
            end

  def self.streak_high_score_board(a)
    i = 0
    sorted_scored = User.all.sort_by{|user| user.streak_high_score}.reverse
      puts ""
      puts "Top 5 Streakers"
      puts "------------"
        sorted_scored.each do |user|
          if i <= 4
            puts "Name: #{user.name} - Score: #{user.streak_high_score}"
            i += 1
          end
        end
      puts ""
      puts "Press Enter to return to Home Screen"
      gets.chomp
      puts "What would you like to do next?"
      # UserInterface.user_homescreen(a)
      self.return_screen(a)
  end

  def self.timed_high_score_board(a)
    i = 0
    sorted_scored = User.all.sort_by{|user| user.timed_high_score}.reverse
      puts ""
      puts "Top 5 Speedsters"
      puts "------------"
        sorted_scored.each do |user|
          if i <= 4
            puts "Name: #{user.name} - Score: #{user.timed_high_score}"
            i += 1
          end
        end
      puts ""
      puts "Press Enter to return to Home Screen"
      go_back = gets.chomp
      puts "What would you like to do next?"
      self.return_screen(a)
      end


    def self.return_screen(user)
      puts ""
      puts "====================================="
      puts ""
      puts "Welcome Back, #{user.name}!"
      puts "Your Most Recent Score was: #{user.last_score}"
      puts "Your Streaking High Score is: #{user.streak_high_score}"
      puts "Your Timed High Score is: #{user.timed_high_score}"
      puts ""

      puts "What would you like to do next?"
      puts ""
      UserInterface.user_homescreen(user)
  end

end
