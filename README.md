# Simple Student Query Engine

### Built to solve:
```
Given a list of test results (each with a test date, Student ID, and the student's Score)
from an external data source, return the Final Score for each student for a user-provided
date range. A student's Final Score is calculated as the average of his/her 5 highest test
scores. You can assume each student has at least 5 test scores.
```

### Notes:
* For an example implementation, I decided the "external data source" would be a file.
  * Obviously this could easily be a REST/SOAP API, DB, binary dump, etc...
* I also chose a cmd-line interface over a REST or similar.
* For a throwaway code project like this, I focused on code-readability, and not optimization.


```
Usage: main.rb [options]
    -f, --file FILE                  File containing student data, e.g. sampledata.txt
    -i, --id STUDENT                 Student ID (optional to filter output)
    -s, --start [TIME]               Start Timestamp for student test results, e.g. 1409258913
    -e, --end [TIME]                 End Timestamp for student test results, e.g. 1409258913
```

### Example output:
```
> ruby main.rb -s 1 -e 2409258915
Defaulting file input to 'sampledata.txt'!
Student 0001: 90%
Student 0002: 86%
```

### Code Layout:
* student_datasource.rb - holds the main interface for accessing data loaded from an external source.
* student_score.rb - contains the class definition for the record representing an instance of a test result.
* score_calculator.rb - holds the algorithm for determining the final score.
* file_data_source.rb - An example implementation of an external source reader.


## Interview Requirements

* Works?
  * You should be able to test that it works by providing a text file with sample data
and then querying the program via the command line.
  * E.g., 'ruby main.rb -f sampledata.txt -i 0002 -s 1 -e 1509258914'

* Tested?
  * A series of small unit and functional tests exercise the code.
  * Run them with 'rake test'.

* Well designed?
  * Designed using the strategy pattern to allow external sources to be swapped out, e.g. REST API instead of the File loader. Instead of instantiating a FileDataSource object to pass to our StudentDB interface, maybe instantiate a SqlDataSource object.
  * Assumption was that there was a max number of students that would fit into memory.
  * Number of highest grades to average is mutable by just specifying an optional parameter to our ScoreCalculator object.
  * Score dates are stored as timestamps which simplifies a lot of things, and if needed can be converted back to human-readable for display purposes.

* Code readability?
  * Code is short thanks to Ruby's duck and dynamic typing.

* Extendible and maintainable?
  * Should be able to swap out various external sources easily without modifying core code.
  * Code was written to be readable rather than optimized.
  * Should be no problem to put different interfaces on top of this code, e.g. REST interface.
  * Number of highest grades is not hardcoded, but does default to 5.