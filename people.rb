class Person
	def initialize(name)
		@name = name
	end

	def greeting
		puts "Hi, my name is #{@name}!"
	end
end

class Student < Person
	def learn
		puts "I get it!"
	end
end

class Instructor < Person

	def teach 
		puts "Everything in Ruby is an Object!"
	end
end

chris = Instructor.new("Chris")
chris.greeting

christina = Student.new("Christina")
christina.greeting

chris.teach
christina.learn

christina.teach

# the .teach method will not work on the student instance because that method was not defined in the student class. 