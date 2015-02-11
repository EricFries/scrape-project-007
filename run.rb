require 'Nokogiri'
require 'open-uri'
require_relative 'scraper.rb'

def students_profile (students_array)
    students_array.each do |student_hash|
    new_student = Student.new(student_hash[:name], student_hash[:education], student_hash[:bio], student_hash[:work])
  end 
end 



class Student
    @@all = []
    attr_accessor :name, :education, :bio, :work  

    def initialize(name, education, bio, work)
        @name = name
        @education = education
        @bio = bio
        @work = work
    
        @@all << self
    end

    def self.find_student_by_name(search_name)
        answer = nil
        @@all.each do |student|
          if student.name == search_name
            answer = student
          end
        end 
      puts answer.name
      puts answer.education
      puts answer.bio
      puts answer.work 
    end

    def self.all
        @@all 
    end 


end


def run
  students_array = create_student_hash(get_student_links)
    students_profile (students_array)
    puts "Welcome to The Flatiron School! Please enter a student's name..."
    user_command = gets.chomp
      Student.find_student_by_name(user_command) 
end
run