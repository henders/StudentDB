#!/usr/bin/ruby

# gem "minitest"
require "minitest/autorun"

require_relative '../score_calculator'


class TestCalculator < MiniTest::Unit::TestCase

	def test_empty_student_array
		calculator = ScoreCalculator.new
		scores = calculator.get_all_student_final_score([], 1, 100)
		assert_equal 0, scores.length
	end

	def test_single_student_record
		calculator = ScoreCalculator.new
		students = []
		students << StudentScore.new(1,"2",3)
		scores = calculator.get_all_student_final_score(students, 1, 100)
		assert_equal 1, scores.length
		assert_equal 3, scores["2"]
	end

	def test_single_student_multi_scores
		calculator = ScoreCalculator.new
		students = []
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",1)
		scores = calculator.get_all_student_final_score(students, 1, 100)
		assert_equal 1, scores.length
		assert_equal 100, scores["2"]
	end

	def test_multi_student_multi_scores
		calculator = ScoreCalculator.new
		students = []
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"2",1)
		students << StudentScore.new(1,"3",100)
		students << StudentScore.new(1,"3",1)
		students << StudentScore.new(1,"3",1)
		students << StudentScore.new(1,"3",1)
		students << StudentScore.new(1,"3",1)
		students << StudentScore.new(1,"3",1)
		scores = calculator.get_all_student_final_score(students, 1, 100)
		assert_equal 2, scores.length
		assert_equal 100, scores["2"]
		assert_equal 20, scores["3"]
	end

	def test_multi_student_single_scores
		calculator = ScoreCalculator.new
		students = []
		students << StudentScore.new(1,"2",100)
		students << StudentScore.new(1,"3",1)
		scores = calculator.get_all_student_final_score(students, 1, 100)
		assert_equal 2, scores.length
		assert_equal 100, scores["2"]
		assert_equal 1, scores["3"]
	end

end