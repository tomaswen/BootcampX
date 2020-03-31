--Total Teacher Assistance Requests
SELECT count(assistance_requests.*) as total_assistances, teachers.name
FROM teachers 
JOIN assistance_requests ON teacher_id = teachers.id
WHERE teachers.name = 'Waylon Boehm'
GROUP BY teachers.name;

--Total Student Assistance Requests
SELECT count(assistance_requests.*) as total_assistances, students.name
FROM students
JOIN assistance_requests ON student_id = students.id
WHERE name = 'Elliot Dickinson'
GROUP BY students.name;

--Assistance Requests Data
SELECT teachers.name as teacher, students.name as student, assignments.name as assignment, (completed_at - started_at) as duration
FROM assistance_requests 
JOIN teachers ON assistance_requests.teacher_id = teachers.id
JOIN students ON assistance_requests.student_id = students.id
JOIN assignments ON assistance_requests.assignment_id = assignments.id
ORDER BY duration;

--Average Assistance Time
SELECT AVG(completed_at - started_at) as average_assistance_request_duration
FROM assistance_requests;

--Average Cohort Assistance Time
SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time;

--Cohort With Longest Assistances
SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;

--Average Assistance Request Wait Time
SELECT AVG(started_at - created_at) as average_wait_time
FROM assistance_requests;

--Total Cohort Assistance Duration
SELECT cohorts.name, SUM(completed_at - started_at) as total_duration
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;

--Cohort Average Assistance Duration
SELECT avg(total_duration) as average_total_duration
FROM (
   SELECT cohorts.name, SUM(completed_at - started_at) as total_duration
   FROM assistance_requests 
   JOIN students ON students.id = assistance_requests.student_id
   JOIN cohorts ON cohorts.id = cohort_id
   GROUP BY cohorts.name
) as total_cohort_assistance_duration;

--Most Confusing Assignments
SELECT assignments.id, name , day, chapter, count(assistance_requests.*) as total_request
FROM assignments
JOIN assistance_requests ON assignment_id = assignments.id
GROUP BY assignments.id
ORDER BY total_request DESC;

--Total Assignments and duration
SELECT day, count(*) as number_of_assignments, sum(duration) as duration
FROM assignments
GROUP BY day
ORDER BY day;

--Name of Teachers That Assisted && Name of Teachers and Number of Assistances
SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort, count(assistance_requests.*) as total_assistances 
FROM teachers 
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = students.cohort_id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teachers.name;
