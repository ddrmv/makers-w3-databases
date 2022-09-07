CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  start_date date
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort_121212 foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);

TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO cohorts (name, start_date)
  VALUES('August 2022', '2022-07-25');
INSERT INTO cohorts (name, start_date)
  VALUES('September 2022', '2022-08-25');

INSERT INTO students (name, cohort_id)
  VALUES('Student Name 1', 1);
INSERT INTO students (name, cohort_id)
  VALUES('Student Name 2', 2);