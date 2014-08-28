require 'optparse'
require 'time'
require_relative "student_db"


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on("-f", "--file FILE", "File containing student data") do |file|
    options[:file] = file
  end
  opts.on("-i", "--id STUDENT", "Student ID") do |id|
    options[:id] = id
  end
  opts.on("-s", "--start [TIME]", "Start Timestamp, e.g. 1409258913") do |time|
    options[:start] = time.to_i
  end
  opts.on("-e", "--end [TIME]", "End Timestamp, e.g. 1409258913") do |time|
    options[:end] = time.to_i
  end
end.parse!

# Some basic sanitation
if !options[:file]
	puts "You must specify a file to load data from!"
elsif !options[:id]
	puts "You must specify a student ID!"
elsif !options[:start] or options[:start].to_i <= 0
	puts "You must specify a start timestamp, e.g. 1409054979!"
elsif !options[:end] or options[:end].to_i <= 0
	puts "You must specify an end timestamp, e.g. 1409054979!"
else
	begin
		# We are explicitly using a file as an external source.
		external_data_source = FileDataSource.new(options[:file])
		studentDB = StudentDB.new(external_data_source)
		finalScore = studentDB.get_student_final_score(options[:id], options[:start], options[:end])
		puts "The answer = #{finalScore}"
	rescue Exception => e
		puts "Unfortunately we encountered a problem: #{e.to_s}"
		puts "Please contact your closest administrator!"
	end
end

