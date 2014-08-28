
#
class StudentScore
	attr_reader :date, :score
	def initialize(date, score)
		@date = date
		@score = score
	end
end
