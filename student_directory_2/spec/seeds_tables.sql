TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO cohorts (name, start_date)
  VALUES('August 2022', '2022-07-25');
INSERT INTO cohorts (name, start_date)
  VALUES('September 2022', '2022-08-25');

INSERT INTO students (name, cohort_id)
  VALUES('Student Name 1', 1);
INSERT INTO students (name, cohort_id)
  VALUES('Student Name 2', 2);
  INSERT INTO students (name, cohort_id)
  VALUES('Student Name 3', 1);