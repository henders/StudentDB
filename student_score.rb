# This is just our item class to be used with containers.
# It's a simple representation of a student's score.
class StudentScore
	attr_reader :date, :score, :id
	def initialize(date, id, score)
		@date = date
		@id = id
		@score = score
	end
end
