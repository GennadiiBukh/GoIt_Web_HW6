-- 1.Знайти 5 студентів із найбільшим середнім балом з усіх предметів.
SELECT students.id, students.name, AVG(grades.grade) AS average_grade
FROM students
JOIN grades ON students.id = grades.student_id
GROUP BY students.id, students.name
ORDER BY average_grade DESC
LIMIT 5;

-- 2.Знайти студента із найвищим середнім балом з певного предмета.
SELECT students.id, students.name, AVG(grades.grade) AS average_grade
FROM students
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.name = 'Фізика'  -- Зафіксована назва предмету
GROUP BY students.id, students.name
ORDER BY average_grade DESC
LIMIT 1;

-- 3.Знайти середній бал у групах з певного предмета.
SELECT groups.name AS group_name, AVG(grades.grade) AS average_grade
FROM groups
JOIN students ON groups.id = students.group_id
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.name = 'Хімія' -- Зафіксована назва предмету
GROUP BY group_name

--4.Знайти середній бал на потоці (по всій таблиці оцінок).
SELECT AVG(grades.grade) AS average_grade
FROM grades

--5.Знайти які курси читає певний викладач.
SELECT subjects.name AS course_name
FROM subjects
WHERE subjects.teacher_id = (SELECT id FROM teachers WHERE name = 'Трохим Влох') -- Зафіксоване ім'я викладача




