require 'cohort_repository'

def reset_student_directory_2_tables
  seed_sql = File.read('spec/seeds_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do 
    reset_student_directory_2_tables
  end

  describe "#find_wint_students(id)" do
    it "returns one cohort with its students" do
      repo = CohortRepository.new
      cohort = repo.find_with_students(1)
      expect(cohort.students.length).to eq 2
      
      expect(cohort.id).to eq "1"
      expect(cohort.name).to eq "August 2022"
      expect(cohort.start_date).to eq "2022-07-25"

      expect(cohort.students.first.id).to eq "1"
      expect(cohort.students.first.name).to eq "Student Name 1"
      expect(cohort.students.first.cohort_id).to eq "1"

      expect(cohort.students.last.id).to eq "3"
      expect(cohort.students.last.name).to eq "Student Name 3"
      expect(cohort.students.last.cohort_id).to eq "1"
    end
  end
end