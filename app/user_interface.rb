class UserInterface

  def self.user_homescreen(user)
      puts "Enter 1 to START STREAKING!"
      puts "Enter 2 to Start NEED FOR SPEED!"
      puts "Enter 3 to See Streaker Hall Of Fame"
      puts "Enter 4 to See Speedsters Hall Of Fame"
      puts "Enter 5 to See Your Correct Questions"
      puts "Enter 6 to Modify User Name"
      puts "Enter 7 to Delete User"
      puts "Enter 8 to Go To Welcome Screen"
      puts "Enter 9 to EXIT"
      choice = gets.chomp.downcase

      case choice
      when "1"
        puts ""
        puts "Game instructions:"
        puts "Answer correctly as many questions in a row as you can."
        puts "If you get a wrong answer the game will end."
        puts "Press ENTER to Play!"
        gets.chomp
        Question.give_user_questions(user)
        user.save
      when "2"
        puts ""
        puts "Game instructions:"
        puts "This is a TIMED game!"
        puts "You have 30 seconds to answer as many questions as you can."
        puts "The game will continue until the time runs out, even if you get wrong answers."
        puts "Press ENTER to Play!"
        gets.chomp
        TimedGame.give_user_questions(user)
      when "3"
        Question.streak_high_score_board(user)
      when "4"
        Question.timed_high_score_board(user)
      when "5"
        UsersQuestions.got_right(user)
      when "6"
        puts ""
        puts "Please enter New User Name & Press Enter"
        new_name = gets.chop
        user.name = new_name
        user.save
        Question.return_screen(user)
      when "7"
        puts "Are you sure you want to DELETE your user profile, \"#{user.name}\"?"
        puts "You won't be able to recover your stats."
        puts "Enter 'yes' to confirm or enter any key to return to menu"
        answer = gets.chomp.downcase
        if answer == "yes"
          puts "User \"#{user.name}\" DELETED!"
          user.destroy
        else
          self.user_homescreen(user)
        end
      when "8"
        User.welcome_user
      when "9"
        puts ""
        puts "Have a good day!"
      when "exit"
        puts ""
        puts "Have a good day!"
      else
          puts "------------------------------"
          puts "Please Select A Valid Option"
          Question.return_screen(user)
      end
  end
end
