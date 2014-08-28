require_relative "student_score"
require_relative "file_data_source"

# This is our main class. It allows you to override the external data source
# via the 'strategy' pattern.
# It exposes our single API required which is the get_students.
# It also exposes the map of student score objects in read-only state if required.
class StudentDataSource
	def initialize(data_source)
		@data_source = data_source
	end

	def get_students(filter_id = nil)
		students = []
		@data_source.get_students(students, filter_id)
		return students
	end
end
