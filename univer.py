import sqlite3
from faker import Faker
import random
import datetime

# Встановлення локалізації Faker на українську
fake = Faker('uk_UA')

# Використання оператора контексту для роботи з базою даних та обробки помилок
try:
    with sqlite3.connect('university.db') as conn:
        cursor = conn.cursor()

        # Створення таблиці студентів
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS students (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(255),
                group_id TINYINT,
                FOREIGN KEY (group_id) REFERENCES groups(id)
            )
        ''')
        
        # Створення таблиці груп
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS groups (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(255)
            )
        ''')

        # Створення таблиці викладачів
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS teachers (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(255)
            )
        ''')

        # Створення таблиці предметів
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS subjects (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(255),
                teacher_id TINYINT,
                FOREIGN KEY (teacher_id) REFERENCES teachers(id)
            )
        ''')

        # Створення таблиці оцінок
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS grades (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                student_id TINYINT,
                student_name VARCHAR(255),
                subject_id TINYINT,
                grade TINYINT,
                date_received DATE,
                FOREIGN KEY (student_id) REFERENCES students(id),
                FOREIGN KEY (subject_id) REFERENCES subjects(id)
            )
        ''')

        # Додавання груп
        groups = ['Група А', 'Група Б', 'Група В']
        for group in groups:
            cursor.execute('INSERT INTO groups (name) VALUES (?)', (group,))

        # Додавання викладачів
        for _ in range(3):
            cursor.execute('INSERT INTO teachers (name) VALUES (?)', (fake.name(),))

        # Додавання предметів з випадковим призначенням викладачів
        subjects = [('Алгебра', 1), ('Фізика', 2), ('Історія', 3), ('Біологія', 3), ('Хімія', 2), ('Інформатика', 1), ('Геометрія', 1)]
        for subject in subjects:
            cursor.execute('INSERT INTO subjects (name, teacher_id) VALUES (?, ?)', subject)

        # Додавання студентів та їх імен
        students_data = []
        for _ in range(50):
            name = fake.name()
            group_id = random.randint(1, 3)
            students_data.append((name, group_id))

        cursor.executemany('INSERT INTO students (name, group_id) VALUES (?, ?)', students_data)

        # Додавання оцінок з випадковими іменами студентів
        grades_data = []
        for student_id in range(1, 51):
            for subject_id in range(1, 8):
                student_name = students_data[student_id - 1][0]
                grade = random.randint(60, 100)
                date_received = fake.date_between(start_date="-1y", end_date="today")
                grades_data.append((student_id, student_name, subject_id, grade, date_received))

        cursor.executemany('INSERT INTO grades (student_id, student_name, subject_id, grade, date_received) VALUES (?, ?, ?, ?, ?)', grades_data)

except sqlite3.Error as e:
    print(f"Помилка бази даних: {e}")
