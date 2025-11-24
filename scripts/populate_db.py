import sys
from pathlib import Path

# Добавляем корень проекта (на уровень выше scripts/)
sys.path.append(str(Path(__file__).parent.parent))

from sqlmodel import Session
from db import engine
from models.tables import dtype, dstatus, role, department, employee, document, documentflow, approval
from datetime import datetime

# def clear_database():
#     """Очистка всех таблиц в правильном порядке (с учетом внешних ключей)"""
#     with Session(engine) as session:
#         # Удаляем данные в правильном порядке для избежания нарушений внешних ключей
#         session.exec(text("DELETE FROM Peturova.approval"))
#         session.exec(text("DELETE FROM Peturova.documentflow"))
#         session.exec(text("DELETE FROM Peturova.document"))
#         session.exec(text("DELETE FROM Peturova.employee"))
#         session.exec(text("DELETE FROM Peturova.department"))
#         session.exec(text("DELETE FROM Peturova.dstatus"))
#         session.exec(text("DELETE FROM Peturova.dtype"))
#         session.exec(text("DELETE FROM Peturova.role"))
#         session.commit()
#     print("База данных очищена")

# def populate_database():
#     """Заполнение базы данных красивыми тестовыми данными""" 

with Session(engine) as session:
    # -----------------------
    # Роли
    # -----------------------
    print("Создаем роли...")
    roles = ["автор", "согласующий", "утверждающий", "исполнитель", "администратор", "архивариус"]
    role_objs = [role(name=r) for r in roles]
    session.add_all(role_objs)
    session.commit()
    # session.refresh_all(role_objs)

    # -----------------------
    # Статусы документов
    # -----------------------
    statuses = ["в работе", "на согласовании", "утверждён", "на доработке", "архивирован", "уничтожен"]
    status_objs = [dstatus(name=s) for s in statuses]
    session.add_all(status_objs)
    session.commit()
    # session.refresh_all(status_objs)

    # -----------------------
    # Типы документов
    # -----------------------
    doc_types = [("Приказ", "Приказ по организации"), ("Договор", "Договор с контрагентом")]
    type_objs = [dtype(name=name, description=desc) for name, desc in doc_types]
    session.add_all(type_objs)
    session.commit()
    # session.refresh_all(type_objs)

    # -----------------------
    # Подразделения
    # -----------------------
    dep1 = department(name="Отдел кадров")
    dep2 = department(name="Бухгалтерия")
    session.add_all([dep1, dep2])
    session.commit()
    # session.refresh_all([dep1, dep2])

    # -----------------------
    # Сотрудники
    # -----------------------
    emp1 = employee(
        full_name="Иван Иванов",
        role_id=role_objs[0].id,
        department_id=dep1.id,
        contact_info="ivan@mail.com"
    )
    emp2 = employee(
        full_name="Мария Петрова",
        role_id=role_objs[1].id,
        department_id=dep2.id,
        contact_info="maria@mail.com"
    )
    session.add_all([emp1, emp2])
    session.commit()
    # session.refresh_all([emp1, emp2])

    # Обновим руководителей отделов (после создания сотрудников)
    dep1.head_id = emp1.id
    dep2.head_id = emp2.id
    session.add_all([dep1, dep2])
    session.commit()

    # -----------------------
    # Документы
    # -----------------------
    doc1 = document(
        number="001/23",
        created_at=datetime(2025, 10, 6, 12, 0),
        type_id=type_objs[0].id,
        status_id=status_objs[0].id,
        author_id=emp1.id,
        storage_period=365
    )
    doc2 = document(
        number="002/23",
        created_at=datetime(2025, 10, 5, 9, 30),
        type_id=type_objs[1].id,
        status_id=status_objs[1].id,
        author_id=emp2.id,
        storage_period=730
    )
    session.add_all([doc1, doc2])
    session.commit()
    # session.refresh_all([doc1, doc2])

    # -----------------------
    # Движение документов
    # -----------------------
    flow1 = documentflow(
        document_id=doc1.id,
        sender_id=emp1.id,
        receiver_id=emp2.id,
        sent_at=datetime(2025, 10, 6, 13, 0),
        status="Отправлено"
    )
    flow2 = documentflow(
        document_id=doc2.id,
        sender_id=emp2.id,
        receiver_id=emp1.id,
        sent_at=datetime(2025, 10, 5, 10, 0),
        status="На согласовании"
    )
    session.add_all([flow1, flow2])
    session.commit()

    # -----------------------
    # Согласования
    # -----------------------
    approval1 = approval(
        document_id=doc1.id,
        employee_id=emp2.id,
        approval_date=datetime(2025, 10, 6, 15, 0),
        comment="Согласовано"
    )
    approval2 = approval(
        document_id=doc2.id,
        employee_id=emp1.id,
        approval_date=datetime(2025, 10, 5, 12, 0),
        comment="Нужно доработать"
    )
    session.add_all([approval1, approval2])
    session.commit()

print("База данных успешно заполнена минимальными данными!")

