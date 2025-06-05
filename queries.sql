--  Insert students
INSERT INTO students (first_name, last_name,  email,  major) VALUES
('Ali', 'Mohamadian',  'ali@example.com',  'Computer Science'),
('Reza', 'Amiri',  'maryam@example.com', 'Electical Engineering');

--Insert professors
INSERT INTO professors (first_name, last_name, email, department_id) VALUES
('Ahmad', 'Karimi', 'ahmad@example.com', 1 ),
('Zahra', 'Nori', 'zahra@example.com', 1);

-- insert departments
INSERT INTO departments (name) VALUES ("Basic sciences"),("Biology");


--Insert courses
INSERT INTO courses (name, description, credits, professor_id, department_id) VALUES
('CS50s Introdoction to SQL', 'Its harvard intodotion to databases like sqlite', 4, 1, 1),
('CS50s Introdoction to Computer Science', 'Its harvard intodotion to Computer Science like C ,Python databases'
, 3, 2, 1);

--Insert enrollments
INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1) , (2, 2);

--Insert grades
INSERT INTO grades (student_id, course_id, grade, semester) VALUES
(1, 1, 18.5, 'Fall 2023'),
(2, 2, 17.0, 'Fall 2023');


SELECT *
FROM "students"
WHERE "id" IN (
    SELECT "student_id"
    FROM "grades"
    WHERE "grade" > 17
);


CREATE INDEX "idx_students_email" ON students ("email");

CREATE INDEX "idx_grades_student_course" ON grades ("student_id", "course_id");



CREATE VIEW "student_enrollment_summary" AS
SELECT
    students.id,
    students.first_name || ' ' || students.last_name AS "student_name",
    courses.name,
    enrollments.enrollment_date
FROM students
JOIN enrollments  ON students.id = enrollments.student_id
JOIN courses  ON enrollments.course_id = courses.id;



CREATE VIEW "professor_course_assignments" AS
SELECT
    professors.id,
    professors.first_name || ' ' || professors.last_name AS "professor_name",
    courses.name,
    departments.name AS "department_name"
FROM professors
JOIN courses  ON professors.id = courses.professor_id
JOIN departments  ON courses.department_id = departments.id;
