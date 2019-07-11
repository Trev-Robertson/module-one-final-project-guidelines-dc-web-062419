class UserInterface

  def self.user_homescreen(user)
      puts "Enter 1 to START STREAKING"
      puts "Enter 2 to Start NEED FOR SPEED!"
      puts "Enter 3 to Modify User Name"
      puts "Enter 4 to see Streaker Hall Of Fame"
      puts "Enter 5 to see Speedsters Hall Of Fame"
      puts "Enter 6 to Go To Welcome Screen"
      puts "Enter 7 to Delete User"
      puts "Enter 8 to EXIT"
      choice = gets.chomp.downcase

      case choice
      when "1"
        Question.give_user_questions(user)
        user.save
      # when "2"
        # OPTIONAL game type
      when "2"
        TimedGame.give_user_questions(user)
      when "3"
        puts "Please enter New User Name"
        new_name = gets.chop
        user.name = new_name
        user.save
        UserInterface.user_homescreen(user)
      when "4"
        Question.streak_high_score_board(user)
      when "5"
        Question.timed_high_score_board(user)
      when "6"
        User.welcome_user
      when "7"
        puts "Are you sure you want to delete your user profile?"
        puts "You won't be able to recover your stats."
        puts "Enter 'yes' to confirm or enter any key to return to menu"
        answer = gets.chomp.downcase
        if answer == "yes"
          user.destroy
          puts "User Deleted"
        else
          self.user_homescreen(user)
        end
      when "8"
        puts ""
        puts "Have a good day!"
      when "exit"
        puts ""
        puts "Have a good day!"
      else
          puts "------------------------------"
          puts "Please Select A Valid Option"
          self.user_homescreen(user)
      end
  end
end
