gem "minitest"
require "minitest/autorun"

require_relative 'student_db'


class TestFileLoader < MiniTest::Test
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

	def test_initial_load
		loader = FileDataSource.new("test_data.txt")
		students = {}
		loader.load_data(students)
		assert_not_equal nil, students
		assert_equal 2, students.length
		assert_equal 12, students["123"].length
	end
end

class TestDataSource < MiniTest::Test
	def setup
		file = File.open("test_data.txt", "w")
		file.write("#{Time.now.to_i - 6} 123 91\n")
		file.write("#{Time.now.to_i - 5} 123 64\n")
		file.close
	end

	def after
		File.delete("test_data.txt")
	end

	def test_using_file_source
		loader = DataSource.new(FileDataSource.new("test_data.txt"))
		assert_not_equal nil, students
		assert_equal 1, students.length
		assert_equal 2, loader.students["123"].length
	end

end