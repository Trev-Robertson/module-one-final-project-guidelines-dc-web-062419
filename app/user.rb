class User < ActiveRecord::Base

    has_many :user_questions
    has_many :questions, through: :user_questions


    def self.welcome_user
        puts Rainbow("Welcome, Please Enter A Number From The Following Choices")
        puts ""
        puts Rainbow("1. Login or Create User")
        # puts "2. Create New User"
        puts Rainbow("2. Quit")
        choice = gets.chomp

        case choice
        when "1"
         user = self.login
         UserInterface.user_homescreen(user)
        # when "2"
        #   choice = self.login
        #   UserInterface.user_homescreen(choice)
      when "2"
            puts ""
            puts Rainbow("Have a good day!")
            choice
        else
            puts "Please Select A Valid Option"
            self.welcome_user
        end
    end

    def self.login
        puts ""
        puts "Returning users: Please Enter your Username!"
        puts "New users: Please create a Username with less than 10 characters."
        puts "Only A-z, 0-9, and '_' '-' are allowed, no spaces."
        name = gets.chomp
        while !name.match? /\A[a-zA-Z\-_0-9]{1,10}\z/
          puts "Username not accepted. Please create a Username with less than 10 characters, using a-z"
          name = gets.chomp
        end
      current_user = self.find_or_create_by(name: name)
      current_user.streak_high_score ||= 0
      current_user.timed_high_score ||= 0
      current_user.last_score ||= 0
      current_user.save
      puts "==========================================="
      puts ""
      puts "Hi, #{current_user.name}!"
      puts  "High Score: #{current_user.high_score}"
      puts  "Last Score: #{current_user.last_score}"
      puts ""
      current_user
    end

end
