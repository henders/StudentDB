gem "minitest"
require "minitest/autorun"

require_relative '../student_datasource'


class TestDataSource < MiniTest::Unit::TestCase
	def setup
		file = File.open("test_data.txt", "w")
		file.write("#{Time.now.to_i - 6} 123 91\n")
		file.write("#{Time.now.to_i - 5} 123 64\n")
		file.close
	end

	def after
		File.delete("test_data.txt")
	end

	class FakeDataSource
		def get_students(students, filter)
			students << StudentScore.new(1,"2",3)
		end
	end
	def test_fake_external_data_source

		loader = StudentDataSource.new(FakeDataSource.new)
		students = loader.get_students
		assert students
		assert_equal 1, students.length
	end

	def test_using_file_source
		loader = StudentDataSource.new(FileDataSource.new("test_data.txt"))
		students = loader.get_students
		assert students
		assert_equal 2, students.length
	end

	def test_bad_format_propogates_exception
		file = File.open("test_data.txt", "w")
		file.write("0001 45\n")
		file.close

		loader = StudentDataSource.new(FileDataSource.new("test_data.txt"))
		assert_raises RuntimeError do
			students = loader.get_students(students)
		end
	end

end