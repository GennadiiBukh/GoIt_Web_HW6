import sqlite3

# Виконати запит з файлу
def execute_query(file_name):
    try:
        with open(file_name, 'r') as query_file:
            sql = query_file.read()

        conn = sqlite3.connect('university.db')
        cursor = conn.cursor()
        cursor.execute(sql)

        result = cursor.fetchall()
        return result

    except sqlite3.Error as e:
        print(f"Помилка бази даних: {e}")

def choos_query():
    while True:
        print('Запити до бази даних:')
        print('1.Знайти 5 студентів із найбільшим середнім балом з усіх предметів.')
        print('2.Знайти студента із найвищим середнім балом з певного предмета.')
        print('3.Знайти середній бал у групах з певного предмета.')
        print('4.Знайти середній бал на потоці (по всій таблиці оцінок).')
        print('5.Знайти які курси читає певний викладач.')
        print('6.Знайти список студентів у певній групі.')
        print('7.Знайти оцінки студентів у окремій групі з певного предмета.')
        print('8.Знайти середній бал, який ставить певний викладач зі своїх предметів.')
        print('9.Знайти список курсів, які відвідує студент.')
        print('10.Список курсів, які певному студенту читає певний викладач.')
        
        num = input('Введіть номер запиту або "Enter" для виходу >> ')
        if not num:
            break
        query_file = f'query_{num}.sql'
        result = execute_query(query_file)
        print(f"Результат запиту {num}:")
        for row in result:
            print(row)
        input('Введіть "Enter" для продовження')

if __name__ == "__main__":
    choos_query()




