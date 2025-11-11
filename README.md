# Лабораторная работа №3 — Система документооборота

**Студент:** Петурова Надежда Игоревна  
**Группа:** ИТвД 1.1  
**Дата:** 11 ноября 2025

---

## Используемая СУБД
- **PostgreSQL**
- Версия: 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
- Сервер: `176.108.247.125:5432`
- База данных: `mis2025`
- Схема: `Peturova`
- Пользователь: `student` / `mis2025!`

---

## Дамп базы данных
- **Файл:** `dump.sql`
- **Создан:** 11 ноября 2025, 16:43
- **Формат:** SQL (INSERT-команды)
- **Содержит:**
  - 8 таблиц
  - Минимальные данные + дубли (для проверки)
  - Полная структура: `CREATE TABLE`, `SEQUENCE`, `DEFAULT`, `PRIMARY KEY`, `FOREIGN KEY`

---

## Структура проекта
lab3/
├── db.py                  # Подключение к PostgreSQL через SQLModel
├── models/
│   └── tables.py          # Модели: Role, DStatus, DType, Department, Employee, Document, DocumentFlow, Approval
├── scripts/
│   └── populate_db.py     # Очистка + заполнение минимальными данными
├── services/
│   └── requests.py        # 7 бизнес-процессов (FastAPI + SQLModel)
├── main.py                # FastAPI приложение
├── test_requests.py       # Проверка бизнес-логики (requests)
├── dump.sql               # Дамп базы (PostgreSQL)
└── README.md              # Этот файл

---

## Запуск проекта

### 1. Установить зависимости
pip install fastapi uvicorn sqlmodel psycopg2-binary requests

### 2. Заполнить базу
python -m scripts.populate_db

### 3. Проверить бизнес-логику
python test_requests.py

### 4. Запустить API
uvicorn main:app --reload

Документация API: http://127.0.0.1:8000/docs

---

## Пункт 6 — Реализованные процессы предметной области

| № | Процесс                            | Эндпоинт                              |
|---|------------------------------------|---------------------------------------|
| 1 | Все документы                      | `GET /documents/`                     |
| 2 | Документы автора                   | `GET /documents/author/{author_id}`   |
| 3 | История движения документа         | `GET /documents/{doc_id}/history`     |
| 4 | Согласования по документу          | `GET /documents/{doc_id}/approvals`   |
| 5 | Документы на согласовании у сотрудника | `GET /employees/{emp_id}/pending` |
| 6 | Роль сотрудника                    | `GET /employees/{emp_id}/role`        |
| 7 | Руководитель подразделения         | `GET /departments/{dept_id}/head`     |

---

## Тестирование (пример из `test_requests.py`)

import requests

# Все документы
response = requests.get("http://127.0.0.1:8000/documents/")
print(response.json())

# Документы автора
response = requests.get("http://127.0.0.1:8000/documents/author/1")
print(response.json())

---

## Результаты тестирования
- Все 7 процессов работают корректно
- Данные из `dump.sql` успешно загружаются
- Swagger UI доступен по адресу: /docs

---

## Пункт 7 — Результат
- **GitHub:** https://github.com/NayaPetu/lab3
- **Архив:** `document-lab3.zip`
- **СУБД:** PostgreSQL
- **Дамп:** `dump.sql`

---

**Лабораторная работа 3 выполнена полностью.**