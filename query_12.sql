--12.Оцінки студентів у певній групі з певного предмета на останньому занятті.
SELECT students.name AS student, groups.name AS groupe, subjects.name AS subj, grades.grade, MAX(grades.date_received) AS last_date 
FROM students
JOIN groups ON students.group_id = groups.id 
JOIN subjects ON subjects.id = 2 -- Вибраний предмет 
JOIN grades ON students.id = grades.student_id AND subjects.id = grades.subject_id
WHERE groups.id = 3 -- Вибрана група
GROUP BY student, groupe, subj, grades.grade
HAVING grades.date_received = MAX(grades.date_received)