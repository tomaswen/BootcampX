const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

const argvArr = process.argv.slice(2);
const cohortName = argvArr[0];
const limitNumber = argvArr[1] || 5;
const values = [`%${cohortName}%`, limitNumber]

pool.query(`
SELECT students.id, students.name, cohorts.name as cohort_name
FROM students
JOIN cohorts ON students.cohort_id = cohorts.id
WHERE cohorts.name LIKE $1
LIMIT $2;
`, values)
.then(res => {
  res.rows.forEach(user => {
   console.log(`${user.name} has an id of ${user.id} and was in the ${user.cohort_name} cohort`);
  })
});