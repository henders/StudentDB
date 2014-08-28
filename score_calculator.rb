require_relative "student_score"

# Our class to determine the student scores given a list of student data.
class ScoreCalculator
	attr_accessor :num_highest_scores

	def initialize(num_highest_scores = 5)
		@num_highest_scores = num_highest_scores
	end

	# Given a list of students (date, it, score), return a map of StudentId -> FinalScore
	def get_all_student_final_score(students, start_date, end_date)
		scores_to_average = {}
		students.each do |student|
			# initialize the scores_to_average object per student to empty array if not done already
			if !scores_to_average.has_key? student.id
				scores_to_average[student.id] = []
			end

			# Check if the dates fall within the given range
			if student.date >= start_date and student.date <= end_date
				# Initalize the current lowest score to compare the current score to.
				lowest_score = 0
				if !scores_to_average[student.id].empty?
					lowest_score = scores_to_average[student.id].last
				end

				# If this is higher then the currently tracked lowest score, then save it.
				if lowest_score < student.score or
				   scores_to_average[student.id].length < @num_highest_scores
					# Check if we haven't reached our current max high scores.
					# If we have, then we need to make room by popping off the lowest score.
				    if scores_to_average[student.id].length >= @num_highest_scores
					    # Pop off the first element, and push new one, then reverse sort.
					    # So that smallest score is at end
					    scores_to_average[student.id].pop
					end
					# Push on this new higher score and sort the array so that new lowest score goes at end.
				    scores_to_average[student.id] << student.score
				    scores_to_average[student.id].sort!
				    # Always keep the lowest scores ready to be popped off the end.
				    scores_to_average[student.id].reverse!
				end
			end
		end

		# Now average the set of highest scores.
		final_scores = {}
		scores_to_average.each do |id, scores_to_average|
			final_scores[id] = 0
			# puts "Averaging student '#{id}' scores: #{scores_to_average}"
			scores_to_average.each { |score| final_scores[id] += score }
			if !scores_to_average.empty?
				final_scores[id] /= scores_to_average.length
			end
		end
		return final_scores
	end
end