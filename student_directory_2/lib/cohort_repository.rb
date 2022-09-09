require_relative 'cohort'
require_relative 'student'
require_relative 'database_connection'

class CohortRepository
  def find_with_students(id)
    sql = 'SELECT
            cohorts.id AS "cohort_id",
            cohorts.name AS "cohort_name",
            cohorts.start_date,
            students.id AS "student_id",
            students.name AS "student_name",
            students.cohort_id
          FROM cohorts
          JOIN students
          ON students.cohort_id = cohorts.id
          WHERE
            cohorts.id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    cohort = Cohort.new
    cohort.id = result_set.first['cohort_id']
    cohort.name = result_set.first['cohort_name']
    cohort.start_date = result_set.first['start_date']
    result_set.each do |record|
      student = Student.new
      student.id = record['student_id']
      student.name = record['student_name']
      student.cohort_id = record['cohort_id']
      cohort.students << student
    end
    return cohort
  end
end