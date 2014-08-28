gem "minitest"
require "minitest/autorun"

require_relative '../file_data_source'


class TestFileLoader < MiniTest::Unit::TestCase
	def setup
		file = File.open("test_data.txt", "w")
		file.write("#{Time.now.to_i - 10} 0001 45\n")
		file.write("#{Time.now.to_i - 9} 0001 55\n")
		file.write("#{Time.now.to_i - 8} 0001 51\n")
		file.write("#{Time.now.to_i - 7} 0001 83\n")
		file.write("#{Time.now.to_i - 6} 0001 91\n")
		file.write("#{Time.now.to_i - 5} 0001 64\n")
		file.write("#{Time.now.to_i - 10} 0002 45\n")
		file.write("#{Time.now.to_i - 9} 0002 55\n")
		file.write("#{Time.now.to_i - 8} 0002 51\n")
		file.write("#{Time.now.to_i - 7} 0002 83\n")
		file.write("#{Time.now.to_i - 6} 0002 91\n")
		file.write("#{Time.now.to_i - 5} 0002 64\n")
		file.close
	end

	def test_basic_load
		loader = FileDataSource.new("test_data.txt")
		students = []
		loader.get_students(students)
		assert students
		assert_equal 12, students.length
	end

	def test_load_with_filter
		loader = FileDataSource.new("test_data.txt")
		students = []
		loader.get_students(students, "0002")
		assert students
		assert_equal 6, students.length
	end

	def test_bad_format_throws_exception
		file = File.open("test_data.txt", "w")
		file.write("0001 45\n")
		file.close

		loader = FileDataSource.new("test_data.txt")
		students = []
		assert_raises RuntimeError do
			loader.get_students(students)
		end
	end

end
