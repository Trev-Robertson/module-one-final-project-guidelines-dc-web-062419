class UserInterface

  def self.user_homescreen(user)
      puts "Enter 1 to START STREAKING!"
      puts "Enter 2 to Start NEED FOR SPEED!"
      puts "Enter 3 to See Streaker Hall Of Fame"
      puts "Enter 4 to See Speedsters Hall Of Fame"
      puts "Enter 5 to Modify User Name"
      puts "Enter 6 to Delete User"
      puts "Enter 7 to Go To Welcome Screen"
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
        Question.streak_high_score_board(user)
      when "4"
        Question.timed_high_score_board(user)
      when "5"
        puts ""
        puts "Please enter New User Name"
        new_name = gets.chop
        user.name = new_name
        user.save
        Question.return_screen(user)
      when "6"
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
      when "7"
        User.welcome_user
      when "8"
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
