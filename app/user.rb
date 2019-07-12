class User < ActiveRecord::Base

    has_many :user_questions
    has_many :questions, through: :user_questions


    def self.welcome_user
        puts ""
        puts Rainbow("Welcome to Streakers and Speedsters! Please Enter A Number From The Following Choices")
        puts ""
        puts Rainbow("1. Login")
        puts "2. Create New User"
        puts Rainbow("3. Exit")
        choice = gets.chomp

        case choice
        when "1"
         self.find_current_user
        when "2"
          self.create_new
        when "3"
            puts ""
            puts Rainbow("Have a good day!")
        else
            puts "Please Select A Valid Option"
            self.welcome_user
        end
    end

    def self.create_new
        puts ""
        puts "Please Create Your Username! or enter EXIT to return"
        puts ""
        puts "Valid Usernames have less than 10 characters."
        puts "Only A-z, 0-9, and '_' or '-' are allowed, no spaces."
        name = gets.chomp
        user = self.all.find { |user| name.downcase == user.name.downcase} 
        while !name.match? /\A[a-zA-Z\-_0-9]{1,10}\z/ || name.casecmp("exit") == 0
          puts ""
          puts "Username not accepted. Please create a Username with less than 10 characters. Or Enter 'exit' to return to Welcome Screen"
          puts "Only A-z, 0-9, and '_' or '-' are allowed, no spaces."
          name = gets.chomp
        end
        if name.casecmp("exit") == 0
          self.welcome_user

        elsif user != nil 
          puts ""
          puts "Username already exists, Please try again"
          self.create_new
        else
      user = self.create(name: name, streak_high_score: 0, timed_high_score: 0, last_score: 0 )
      user.save
      self.welcome_header(user)
        end
    end

    def self.welcome_header(user)
      puts "======================================================="
      puts ""
      puts "Hi, #{user.name}!"
      puts "Your Most Recent Score was: #{user.last_score}"
      puts "Your Streaking High Score is: #{user.streak_high_score}"
      puts "Your Timed High Score is: #{user.timed_high_score}"
      puts ""
      UserInterface.user_homescreen(user)
    end

    def self.find_current_user
      puts 'Enter Username'
      user_name = gets.chomp.downcase
      user = self.all.find { |user| user_name == user.name.downcase} 
      if user != nil
        self.welcome_header(user)
      else
        puts ""
        puts "User not found! Please go back and Create New User. Press Enter to return"
          gets.chomp
        puts ""
        self.welcome_user
       end
    end


end
