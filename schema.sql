-- In this SQL file, write (and comment!) the schema of your database
-- including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it



-- Create Students Table
CREATE TABLE students (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "major" TEXT NOT NULL,
    "enrollment_date" DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create Professors Table
CREATE TABLE professors (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "department_id" INTEGER NOT NULL,
    "hire_date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("department_id") REFERENCES departments ("id")
);

-- Create Departments Table
CREATE TABLE departments (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL UNIQUE
);

-- Create Courses Table
CREATE TABLE courses (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "student_id" INTEGER NOT NULL,
    "credits" INTEGER NOT NULL CHECK ("credits" > 0),
    "professor_id" INTEGER NOT NULL,
    "department_id" INTEGER NOT NULL,
    FOREIGN KEY ("professor_id") REFERENCES professors ("id"),
    FOREIGN KEY ("student_id") REFERENCES students ("id"),
    FOREIGN KEY ("department_id") REFERENCES departments ("id")
);

-- Create Enrollments Table
CREATE TABLE enrollments (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "student_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "enrollment_date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("student_id") REFERENCES students ("id") ON DELETE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES courses ("id") ON DELETE CASCADE,
    UNIQUE ("student_id", "course_id")
);

-- Create Grades Table
CREATE TABLE grades (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "student_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "grade" REAL NOT NULL CHECK ("grade" >= 0 AND "grade" <= 20),
    "semester" TEXT NOT NULL,
    FOREIGN KEY ("student_id") REFERENCES students ("id") ON DELETE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES courses ("id") ON DELETE CASCADE,
    UNIQUE ("student_id", "course_id", "semester")
);
