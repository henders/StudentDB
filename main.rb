#!/usr/bin/ruby

require 'optparse'
require 'time'
require_relative "student_datasource"
require_relative "score_calculator"


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on("-f", "--file FILE", "File containing student data") do |file|
    options[:file] = file
  end
  opts.on("-i", "--id STUDENT", "Student ID (optional to filter output)") do |id|
    options[:id] = id
  end
  opts.on("-s", "--start [TIME]", "Start Timestamp for student test results, e.g. 1409258913") do |time|
    options[:start] = time.to_i
  end
  opts.on("-e", "--end [TIME]", "End Timestamp for student test results, e.g. 1409258913") do |time|
    options[:end] = time.to_i
  end
end.parse!

# Some basic sanitation
if !options[:start] or options[:start].to_i <= 0
	puts "You must specify a start timestamp, e.g. 1409054979!"
elsif !options[:end] or options[:end].to_i <= 0
	puts "You must specify an end timestamp, e.g. 1409054979!"
else
	begin
		if !options[:file]
		    options[:file] = "sampledata.txt"
			puts "Defaulting file input to 'sampledata.txt'!"
		end
		# We are using a file as an external source.
		external_data_source = FileDataSource.new(options[:file])
		# Instantiate our generic data source interface and get the list of student test results.
		student_db = StudentDataSource.new(external_data_source)
		students = student_db.get_students(options[:id])
		# Create our calculator
		calculator = ScoreCalculator.new
		final_scores = calculator.get_all_student_final_score(students, options[:start], options[:end])
		final_scores.keys.sort.each do |student_id|
			puts "Student #{student_id}: #{final_scores[student_id]}%"
		end
	rescue Exception => e
		puts "Unfortunately we encountered a problem: #{e.to_s}"
		puts "Please contact your closest administrator!"
	end
end

