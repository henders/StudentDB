require_relative "student_score"
require_relative "file_data_source"

# This is our main class. It allows you to override the external data source 
# via the 'strategy' pattern.
# It exposes our single API required which is the get_final_score.
# It also exposes the map of student score objects in read-only state if required.
class StudentDB
	attr_reader :students

	def initialize(loader)
		@students = {}
		@loader = loader
		load_data
	end

	def load_data
		@loader.load_data(@students)
	end

	# Our main api
	def get_student_final_score(id, start_date, end_date, num_highest_scores = 5)
		if !@students.has_key? id
			raise "No student was found matching that id: '#{id}'"
		else
			scores_to_average = []
			@students[id].each do |score|
				# First check if the dates fall within the given range
				if score.date >= start_date and score.date <= end_date
					# Then check if we want to track this as one of the highest scores
				    if scores_to_average.length < num_highest_scores
					    scores_to_average << score.score
					elsif score.score > scores_to_average.first
					    # Pop off the first element, and push new one, then reverse sort.
					    scores_to_average.pop
					    scores_to_average << score.score
					end
				    scores_to_average.sort!
				    scores_to_average.reverse!
				end
			end

			# Now average the set of highest scores.
			final_score = 0
			scores_to_average.each { |score| final_score += score }
			if !scores_to_average.empty?
				final_score /= scores_to_average.length
			end
			return final_score
		end
	end
end
