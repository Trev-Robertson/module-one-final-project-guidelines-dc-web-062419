class UsersQuestions < ActiveRecord::Base
    belongs_to :user
    belongs_to :question

  def self.got_right(user)
    User.all.select do |user_info|
      if user == user_info.name
        puts "#{user}"
        self.all.select do |question_user|
      #     # binding.pry
          if user_info.id == question_user.user_id && question_user.got_right == 1
            Question.all.select do |question_info|
              if question_user.question_id == question_info.id
                puts "#{question_info.question} --> #{question_info.correct_answer}"
              end
            end
          end
        end
      end
    end
  end
end
