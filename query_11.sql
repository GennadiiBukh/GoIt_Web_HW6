--11.Середній бал, який певний викладач ставить певному студентові.
SELECT teachers.name AS teacher, students.name AS student_name, ROUND(AVG(grades.grade)) AS average_grade
FROM students
JOIN subjects ON grades.subject_id = subjects.id
JOIN teachers ON subjects.teacher_id = teachers.id
JOIN grades ON students.id = student_id
WHERE students.id = 11 AND teachers.id = 2 --'Певний студент' та 'Певний викладач'
GROUP BY teachers.name, students.name