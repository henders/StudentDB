# Deals with files as the data source for student test result data
# Each record is on 1 line formatted by: <timestamp> <student id> <score>
# E.g.
# > cat datasource.txt
# 1409054979 0001 85
# 1409055000 0002 81
# 1409056000 0001 75
# 1409057000 0002 99
# 1409058100 0001 43
# 1409058200 0002 65
# 1409058300 0001 54
# 1409058400 0002 98
# 1409058500 0001 79
class FileDataSource
	def initialize(filepath = "")
		@filepath = filepath
	end

	# Get the list of students, optionally filtered by 'id'
	def get_students(students, filter_id = nil)
		if !@filepath or !File.exist? @filepath
			raise "File '#{@filepath}' does not exist"
		else
			@file = File.open(@filepath)
			# Going to assume format of: <date> <id> <score>
			# We'll allow spaces, tabs, or commas to delimit entries
			@file.each do |line|
				fields = line.strip.split(/[ \t,]/)
				if fields.length != 3
					raise "Badly formatted input file #{@filepath}!"
				end
				(date, id, score) = fields
				student_score = StudentScore.new(date.to_i, id, score.to_i)
				# Filter if requested
				if !filter_id or filter_id == student_score.id
					students << student_score
				end
			end
		end
	end
end
