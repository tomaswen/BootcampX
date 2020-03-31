SELECT day, count(*) as total_assignments
FROM assignments
GROUP BY day
ORDER BY day;

SELECT day, count(*) as total_assignments
FROM assignments
GROUP BY day
HAVING count(*) >= 10
ORDER BY day;

SELECT cohorts.name as cohort_name, count(students.*) as student_count
FROM cohorts 
JOIN students ON cohorts.id = students.cohort_id
GROUP BY cohorts.name
HAVING count(students.*) >= 18
ORDER BY student_count;

SELECT cohorts.name as cohort, count(assignment_submissions.*) as total_submissions
FROM cohorts 
JOIN students ON cohorts.id = students.cohort_id
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
GROUP BY cohorts.name
ORDER BY total_submissions DESC;

SELECT students.name as student, AVG(assignment_submissions.duration) as avg_duration
FROM assignment_submissions
JOIN students ON assignment_submissions.student_id = students.id
WHERE students.end_date IS NULL
GROUP BY students.name
ORDER BY avg_duration DESC;

SELECT students.name as student, AVG(assignment_submissions.duration) as avg_duration, AVG(assignments.duration) as estimated_avg_duration
FROM assignment_submissions
JOIN students ON assignment_submissions.student_id = students.id
JOIN assignments ON assignment_submissions.assignment_id = assignments.id
WHERE students.end_date IS NULL
GROUP BY students.name
HAVING AVG(assignment_submissions.duration) < AVG(assignments.duration)
ORDER BY avg_duration;