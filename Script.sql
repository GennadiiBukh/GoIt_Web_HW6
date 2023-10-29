-- 1.Знайти 5 студентів із найбільшим середнім балом з усіх предметів.
SELECT students.id, students.name, ROUND(AVG(grades.grade)) AS average_grade
FROM students
JOIN grades ON students.id = grades.student_id
GROUP BY students.id, students.name
ORDER BY average_grade DESC
LIMIT 5;

-- 2.Знайти студента із найвищим середнім балом з певного предмета.
SELECT students.id, students.name, ROUND(AVG(grades.grade)) AS average_grade, subjects.name 
FROM students
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id = 2 --'Фізика'  -- Зафіксована назва предмету
GROUP BY students.id, students.name
ORDER BY average_grade DESC
LIMIT 1;

-- 3.Знайти середній бал у групах з певного предмета.
SELECT groups.name AS group_name, subjects.name, ROUND(AVG(grades.grade)) AS average_grade
FROM groups
JOIN students ON groups.id = students.group_id
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id = 5 --'Хімія' -- Зафіксована назва предмету
GROUP BY group_name

--4.Знайти середній бал на потоці (по всій таблиці оцінок).
SELECT ROUND(AVG(grades.grade)) AS average_grade
FROM grades

--5.Знайти які курси читає певний викладач.
SELECT subjects.name AS course_name, teachers.name AS teacher_name
FROM subjects
JOIN teachers ON subjects.teacher_id = teachers.id  
WHERE subjects.teacher_id = 1 --'Певний викладач'

--6.Знайти список студентів у певній групі.
SELECT students.id AS id, students.name AS students_name, groups.name AS groupe
FROM students
JOIN groups ON students.group_id = groups.id 
WHERE group_id = 2 -- Вибрана група "Б"

--7.Знайти оцінки студентів у окремій групі з певного предмета.
SELECT students.name AS student_name, groups.name, subjects.name AS subject, grades.grade
FROM students
JOIN groups ON students.group_id = groups.id
JOIN subjects ON grades.subject_id = subjects.id
JOIN grades ON students.id = grades.student_id
WHERE groups.id = 3 --'Певна група'
AND subjects.id = 2 --'Певний предмет'

--9.Знайти список курсів, які відвідує студент.
SELECT students.name AS student_name, subjects.name AS subject
FROM subjects
JOIN students
JOIN grades ON subjects.id = subject_id AND students.id = student_id
WHERE students.id = 17 --'Певний студент'

--10.Список курсів, які певному студенту читає певний викладач.
SELECT students.name AS student_name, subjects.name AS subject, teachers.name AS teacher
FROM subjects
JOIN students
JOIN teachers ON subjects.teacher_id = teachers.id
JOIN grades ON students.id = student_id AND subjects.id = subject_id 
WHERE students.id = 10 AND teachers.id = 2 --'Певний студент' та 'Певний викладач'

--11.Середній бал, який певний викладач ставить певному студентові.
SELECT teachers.name AS teacher, students.name AS student_name, ROUND(AVG(grades.grade)) AS average_grade
FROM students
JOIN subjects ON grades.subject_id = subjects.id
JOIN teachers ON subjects.teacher_id = teachers.id
JOIN grades ON students.id = student_id
WHERE students.id = 11 AND teachers.id = 2 --'Певний студент' та 'Певний викладач'
GROUP BY teachers.name, students.name

--12.Оцінки студентів у певній групі з певного предмета на останньому занятті.
SELECT students.name AS student, groups.name AS groupe, subjects.name AS subj, grades.grade, MAX(grades.date_received) AS last_date 
FROM students
JOIN groups ON students.group_id = groups.id 
JOIN subjects ON subjects.id = 2 -- Вибраний предмет 
JOIN grades ON students.id = grades.student_id AND subjects.id = grades.subject_id
WHERE groups.id = 3 -- Вибрана група
GROUP BY student, groupe, subj, grades.grade
HAVING grades.date_received = MAX(grades.date_received)
