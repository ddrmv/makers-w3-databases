require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'
# require_relative 'lib/cohort'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('student_directory_2')

repo = CohortRepository.new

cohort = repo.find_with_students(2)

puts "Cohort '#{cohort.name}' has #{cohort.students.length} student(s):"
cohort.students.each_with_index do |student, index|
  puts "#{index + 1} - #{student.name}"
end