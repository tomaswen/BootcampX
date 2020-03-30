SELECT sum(assignment_submissions.duration) AS total_duration
FROM students 
JOIN assignment_submissions 
ON students.id = assignment_submissions.student_id
WHERE students.name = 'Ibrahim Schimmel';

SELECT sum(assignment_submissions.duration) AS total_duration
FROM assignment_submissions
JOIN  students
ON students.id = assignment_submissions.student_id
JOIN cohorts
ON students.cohort_id = cohorts.id
WHERE cohorts.name = 'FEB12';