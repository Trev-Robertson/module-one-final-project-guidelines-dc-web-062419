class UsersQuestions < ActiveRecord::Base
    belongs_to :user
    belongs_to :question

  def self.got_right(user)
    User.all.select do |user_info|
      if user.name == user_info.name
        puts "#{user.name}'s Right Questions:"
        self.all.select do |question_user|
          if user_info.id == question_user.user_id && question_user.got_right == 1
            Question.all.select do |question_info|
              if question_user.question_id == question_info.id
                question_info.question.gsub!("&quot;" , '"')
                question_info.question.gsub!("&#039;" , "'")
                question_info.save
                puts "#{question_info.question} --> #{question_info.correct_answer}"

              end
            end
          end
        end
      end
    end
    puts ""
    puts "Press Enter to Return"
    gets.chomp
    Question.return_screen(user)
  end

end
