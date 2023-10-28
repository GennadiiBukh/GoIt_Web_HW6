--5.Знайти які курси читає певний викладач.
SELECT subjects.name AS course_name
FROM subjects
WHERE subjects.teacher_id = (SELECT id FROM teachers WHERE name = 'Трохим Влох') -- Зафіксоване ім'я викладача
