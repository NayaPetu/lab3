# import sys
# from pathlib import Path

# # Добавляем корень проекта (на уровень выше scripts/)
# sys.path.append(str(Path(__file__).parent.parent))

# from sqlmodel import Session
# from db import engine
# from models.tables import dtype, dstatus, role, department, employee, document, documentflow, approval
# from datetime import datetime, timedelta
# import random


# with Session(engine) as session:
#     # -----------------------
#     # Роли
#     # -----------------------
#     print("1. Заполняем роли (id 1–6)")
#     roles = [
#             role(id=1, name="Автор"),
#             role(id=2, name="Согласующий"),
#             role(id=3, name="Утверждающий"),
#             role(id=4, name="Исполнитель"),
#             role(id=5, name="Архивариус"),
#             role(id=6, name="Администратор"),
#         ]
#     session.add_all(roles)

#     # -----------------------
#     # Статусы документов
#     # -----------------------
#     print("2. Заполняем статусы документов (id 1–9)")
#     statuses = [
#             dstatus(id=1, name="Черновик"),
#             dstatus(id=2, name="На согласовании"),
#             dstatus(id=3, name="Согласован"),
#             dstatus(id=4, name="Утверждён"),
#             dstatus(id=5, name="На доработке"),
#             dstatus(id=6, name="Исполняется"),
#             dstatus(id=7, name="Исполнен"),
#             dstatus(id=8, name="Архивирован"),
#             dstatus(id=9, name="Уничтожен"),
#         ]
#     session.add_all(statuses)

#     # -----------------------
#     # Типы документов
#     # -----------------------
#     print("3. Заполняем типы документов (id 1–8)")
#     doc_types = [
#             dtype(id=1, name="Приказ", description="Распорядительный документ"),
#             dtype(id=2, name="Договор", description="Соглашение сторон"),
#             dtype(id=3, name="Служебная записка", description="Внутренняя переписка"),
#             dtype(id=4, name="Протокол", description="Фиксация обсуждения"),
#             dtype(id=5, name="Акт", description="Подтверждение факта"),
#             dtype(id=6, name="Письмо", description="Официальное обращение"),
#             dtype(id=7, name="Заявление", description="Просьба или предложение"),
#             dtype(id=8, name="Отчёт", description="Результаты работы"),
#         ]
#     session.add_all(doc_types)

#     # -----------------------
#     # Подразделения
#     # -----------------------
#     print("4. Заполняем подразделения (id 1–10)")
#     departments = [
#             department(id=1, name="Руководство"),
#             department(id=2, name="Отдел кадров"),
#             department(id=3, name="Бухгалтерия"),
#             department(id=4, name="Юридический отдел"),
#             department(id=5, name="IT-отдел"),
#             department(id=6, name="Отдел продаж"),
#             department(id=7, name="Отдел закупок"),
#             department(id=8, name="Производственный отдел"),
#             department(id=9, name="Отдел маркетинга"),
#             department(id=10, name="Архив"),
#         ]
#     session.add_all(departments)
#     session.commit()

#     # -----------------------
#     # Сотрудники
#     # -----------------------
#     print("5. Заполняем сотрудников (id 1–11)")
#     employees = [
#            # Руководство
#             employee(id=1, full_name="Смирнов Алексей Петрович",      role_id=6, department_id=1, contact_info="smirnov@company.com, +7 (495) 111-11-11"),
#             employee(id=2, full_name="Кузнецова Ольга Ивановна",     role_id=3, department_id=1, contact_info="kuznetsova@company.com, +7 (495) 111-11-12"),
            
#             # Отдел кадров
#             employee(id=3, full_name="Иванова Мария Сергеевна",       role_id=1, department_id=2, contact_info="ivanova@company.com, +7 (495) 111-11-21"),
#             employee(id=4, full_name="Петров Игорь Васильевич",       role_id=4, department_id=2, contact_info="petrov@company.com, +7 (495) 111-11-22"),
            
#             # Бухгалтерия
#             employee(id=5, full_name="Сидорова Анна Михайловна",      role_id=2, department_id=3, contact_info="sidorova@company.com, +7 (495) 111-11-31"),
#             employee(id=6, full_name="Федоров Дмитрий Александрович",role_id=4, department_id=3, contact_info="fedorov@company.com, +7 (495) 111-11-32"),
            
#             # Юридический отдел
#             employee(id=7, full_name="Николаева Елена Владимировна",  role_id=2, department_id=4, contact_info="nikolaeva@company.com, +7 (495) 111-11-41"),
            
#             # IT-отдел
#             employee(id=8, full_name="Волков Павел Олегович",         role_id=4, department_id=5, contact_info="volkov@company.com, +7 (495) 111-11-51"),
#             employee(id=9, full_name="Лебедева Татьяна Юрьевна",      role_id=1, department_id=5, contact_info="lebedeva@company.com, +7 (495) 111-11-52"),
            
#             # Отдел продаж
#             employee(id=10, full_name="Козлов Андрей Николаевич",     role_id=1, department_id=6, contact_info="kozlov@company.com, +7 (495) 111-11-61"),
            
#             # Архив
#             employee(id=11, full_name="Морозова Людмила Анатольевна", role_id=5, department_id=10, contact_info="morozova@company.com, +7 (495) 111-11-91"),
#         ]
#     session.add_all(employees)
#     session.commit()


#     print("6. Назначаем руководителей подразделений")
#     departments[0].head_id = 1   # Руководство → Смирнов
#     departments[1].head_id = 3   # Кадры → Иванова
#     departments[2].head_id = 5   # Бухгалтерия → Сидорова
#     departments[3].head_id = 7   # Юр. отдел → Николаева
#     departments[4].head_id = 8   # IT → Волков
#     departments[5].head_id = 10  # Продажи → Козлов
#     session.add_all(departments)
#     session.commit()

#     # -----------------------
#     # Документы
#     # -----------------------
#     print("7. Создаём документы (id 1–8)")
#     documents = [
#             document(id=1, number="ПР-001/23", created_at=datetime(2023, 1, 15), type_id=1, status_id=4, author_id=1, storage_period=3650),
#             document(id=2, number="ДГ-002/23", created_at=datetime(2023, 2, 10), type_id=2, status_id=4, author_id=7, storage_period=1825),
#             document(id=3, number="ПР-003/23", created_at=datetime(2023, 10, 5), type_id=1, status_id=4, author_id=1, storage_period=3650),
#             document(id=4, number="СЗ-004/23", created_at=datetime(2023, 9, 1),  type_id=3, status_id=2, author_id=8, storage_period=365),
#             document(id=5, number="СЗ-005/23", created_at=datetime(2023, 5, 18), type_id=3, status_id=4, author_id=3, storage_period=365),
#             document(id=6, number="АКТ-006/23", created_at=datetime(2023, 3, 20), type_id=5, status_id=7, author_id=5, storage_period=1095),
#             document(id=7, number="ОТЧ-007/23", created_at=datetime(2023, 4, 25), type_id=8, status_id=3, author_id=10, storage_period=1825),
#             document(id=8, number="ПР-008/23", created_at=datetime(2023, 11, 1), type_id=1, status_id=2, author_id=1, storage_period=3650),
#         ]
#     session.add_all(documents)
#     session.commit()

#     # -----------------------
#     # Движение документов
#     # -----------------------
#     print("8. Движение документов")
#     flows = [
#             documentflow(id=1, document_id=1, sender_id=1, receiver_id=7, sent_at=datetime(2023, 1, 15, 10, 45), status="На юридическую экспертизу"),
#             documentflow(id=2, document_id=1, sender_id=7, receiver_id=2, sent_at=datetime(2023, 1, 16, 14, 20), status="К утверждению"),
#             documentflow(id=3, document_id=2, sender_id=7, receiver_id=5, sent_at=datetime(2023, 2, 10, 10, 0),  status="На согласование в бухгалтерию"),
#             documentflow(id=4, document_id=2, sender_id=5, receiver_id=2, sent_at=datetime(2023, 2, 11, 11, 30), status="На подпись"),
#             documentflow(id=5, document_id=4, sender_id=8, receiver_id=1, sent_at=datetime(2023, 9, 1, 13, 45), status="На рассмотрение руководству"),
#             documentflow(id=6, document_id=5, sender_id=3, receiver_id=1, sent_at=datetime(2023, 5, 18, 11, 30), status="На утверждение"),
#             documentflow(id=7, document_id=5, sender_id=1, receiver_id=3, sent_at=datetime(2023, 5, 19, 9, 15),  status="Утверждено"),
#         ]
#     session.add_all(flows)
    
#     # -----------------------
#     # Согласования
#     # -----------------------
#     print("9. Согласования")
#     approvals = [
#             approval(id=1, document_id=2, employee_id=5, approval_date=datetime(2023, 2, 11, 10, 15), comment="Финансовые условия приемлемы"),
#             approval(id=2, document_id=2, employee_id=2, approval_date=datetime(2023, 2, 12, 16, 45), comment="Утверждаю"),
#             approval(id=3, document_id=3, employee_id=3, approval_date=datetime(2023, 10, 6, 12, 30), comment="Согласовано кадрами"),
#             approval(id=4, document_id=5, employee_id=1, approval_date=datetime(2023, 5, 19, 9, 0),   comment="Командировка утверждена"),
#         ]
#     session.add_all(approvals)

#     session.commit()
        
        
#     print("\nВсё успешно заполнено! ID везде от 1 и предсказуемые!")



import sys
from pathlib import Path

# Добавляем корень проекта (на уровень выше scripts/)
sys.path.append(str(Path(__file__).parent.parent))

from sqlmodel import Session
from db import engine
from models.tables import dtype, dstatus, role, department, employee, document, documentflow, approval
from datetime import datetime

with Session(engine) as session:
    # -----------------------
    # Роли
    # -----------------------
    print("\n1. Создание ролей...")
    role_author        = role(name="Автор")
    role_agree         = role(name="Согласующий")
    role_approve       = role(name="Утверждающий")
    role_executor      = role(name="Исполнитель")
    role_archivist     = role(name="Архивариус")
    role_admin         = role(name="Администратор")

    session.add_all([role_author, role_agree, role_approve, role_executor, role_archivist, role_admin])
    session.commit()
    # roles = ["Автор", "Согласующий", "Утверждающий", "Исполнитель", "Администратор", "Архивариус"]
    # role_objs = [role(name=r) for r in roles]
    # session.add_all(role_objs)
    # session.commit()
    # session.refresh_all(role_objs)

    # -----------------------
    # Статусы документов
    # -----------------------
    print("\n2. Создание статусов документов...")
    statuses = [
            "Черновик",
            "На согласовании",
            "Согласован",
            "Утвержден",
            "На доработке",
            "Исполняется",
            "Исполнен",
            "Архивирован",
            "Уничтожен"
        ]
    status_objs = [dstatus(name=s) for s in statuses]
    session.add_all(status_objs)
    session.commit()
    # session.refresh_all(status_objs)

    # -----------------------
    # Типы документов
    # -----------------------
    print("\n3. Создание типов документов...")
    doc_types = [
            ("Приказ", "Распорядительный документ по основной деятельности"),
            ("Договор", "Документ, оформляющий соглашение сторон"),
            ("Служебная записка", "Документ внутренней переписки"),
            ("Протокол", "Документ, фиксирующий ход обсуждения и решения"),
            ("Акт", "Документ, подтверждающий факт выполнения работ"),
            ("Письмо", "Официальное обращение к контрагенту"),
            ("Заявление", "Документ с просьбой или предложением"),
            ("Отчет", "Документ с результатами работы")
        ]
    type_objs = [dtype(name=name, description=desc) for name, desc in doc_types]
    session.add_all(type_objs)
    session.commit()
    # session.refresh_all(type_objs)

    # -----------------------
    # Подразделения
    # -----------------------
    print("\n4. Создание подразделений...")
    dep1 = department(name="Руководство")
    dep2 = department(name="Отдел кадров")
    dep3 = department(name="Бухгалтерия")
    dep4 = department(name="Юридический отдел")
    dep5 = department(name="IT-отдел")
    dep6 = department(name="Отдел продаж")
    dep7 = department(name="Отдел закупок")
    dep8 = department(name="Производственный отдел")
    dep9 = department(name="Отдел маркетинга")
    dep10 = department(name="Архив")
    session.add_all([dep1, dep2, dep3, dep4, dep5, dep6, dep7, dep8, dep9, dep10])
    session.commit()
    # session.refresh_all([dep1, dep2])

    # -----------------------
    # Сотрудники
    # -----------------------
    print("5. Заполняем сотрудников (id 1–11) — поимённо")
    emp1 = employee(
            # id=1,
            full_name="Смирнов Алексей Петрович",
            role_id=role_admin.id,          # Администратор
            department_id=dep1.id,     # Руководство
            contact_info="smirnov@company.com, +7 (495) 111-11-11"
        )
    emp2 = employee(
            # id=2,
            full_name="Кузнецова Ольга Ивановна",
            role_id=role_approve.id,          # Утверждающий
            department_id=dep1.id,
            contact_info="kuznetsova@company.com, +7 (495) 111-11-12"
        )
    emp3 = employee(
            # id=3,
            full_name="Иванова Мария Сергеевна",
            role_id=role_author.id,          # Автор
            department_id=dep2.id,     # Отдел кадров
            contact_info="ivanova@company.com, +7 (495) 111-11-21"
        )
    emp4 = employee(
            # id=4,
            full_name="Петров Игорь Васильевич",
            role_id=role_executor.id,          # Исполнитель
            department_id=dep2.id,
            contact_info="petrov@company.com, +7 (495) 111-11-22"
        )
    emp5 = employee(
            # id=5,
            full_name="Сидорова Анна Михайловна",
            role_id=role_agree.id,          # Согласующий
            department_id=dep3.id,     # Бухгалтерия
            contact_info="sidorova@company.com, +7 (495) 111-11-31"
        )
    emp6 = employee(
            # id=6,
            full_name="Федоров Дмитрий Александрович",
            role_id=role_executor.id,          # Исполнитель
            department_id=dep3.id,
            contact_info="fedorov@company.com, +7 (495) 111-11-32"
        )
    emp7 = employee(
            # id=7,
            full_name="Николаева Елена Владимировна",
            role_id=role_agree.id,          # Согласующий
            department_id=dep4.id,     # Юридический отдел
            contact_info="nikolaeva@company.com, +7 (495) 111-11-41"
        )
    emp8 = employee(
            # id=8,
            full_name="Волков Павел Олегович",
            role_id=role_executor.id,          # Исполнитель
            department_id=dep5.id,     # IT-отдел
            contact_info="volkov@company.com, +7 (495) 111-11-51"
        )
    emp9 = employee(
            id=9,
            full_name="Лебедева Татьяна Юрьевна",
            role_id=role_author.id,          # Автор
            department_id=dep5.id,
            contact_info="lebedeva@company.com, +7 (495) 111-11-52"
        )
    emp10 = employee(
            id=10,
            full_name="Козлов Андрей Николаевич",
            role_id=role_author.id,          # Автор
            department_id=dep6.id,     # Отдел продаж
            contact_info="kozlov@company.com, +7 (495) 111-11-61"
        )
    emp11 = employee(
            id=11,
            full_name="Морозова Людмила Анатольевна",
            role_id=role_archivist.id,          # Архивариус
            department_id=dep10.id,    # Архив
            contact_info="morozova@company.com, +7 (495) 111-11-91"
        )
    session.add_all([emp1, emp2, emp3, emp4, emp5, emp6, emp7, emp8, emp9, emp10, emp11])
    session.commit()
    # session.refresh_all([emp1, emp2])

    # Обновим руководителей отделов (после создания сотрудников)
    print("6. Назначаем руководителей подразделений")
    dep1.head_id = emp1.id
    dep2.head_id = emp3.id
    dep3.head_id = emp5.id
    dep4.head_id = emp7.id
    dep5.head_id = emp8.id
    dep6.head_id = emp10.id
    dep10.head_id = emp11.id
    session.add_all([dep1, dep2, dep3, dep4, dep5, dep6, dep10])
    session.commit()

    # -----------------------
    # Документы
    # -----------------------
    print("\n7. Создаём документы (id 1–8)")

    doc1 = document(
        number="ПР-001/23",
        created_at=datetime(2023, 1, 15),
        type_id=type_objs[0].id,    # Приказ
        status_id=status_objs[3].id,  # Утвержден (индекс 3)
        author_id=emp1.id,
        storage_period=3650
    )

    doc2 = document(
        number="ДГ-002/23",
        created_at=datetime(2023, 2, 10),
        type_id=type_objs[1].id,    # Договор
        status_id=status_objs[3].id,  # Утвержден
        author_id=emp9.id,          # Лебедева (автор из IT)
        storage_period=1825
    )

    doc3 = document(
        number="ПР-003/23",
        created_at=datetime(2023, 10, 5),
        type_id=type_objs[0].id,
        status_id=status_objs[3].id,
        author_id=emp1.id,
        storage_period=3650
    )

    doc4 = document(
        number="СЗ-004/23",
        created_at=datetime(2023, 9, 1),
        type_id=type_objs[2].id,    # Служебная записка
        status_id=status_objs[1].id,  # На согласовании
        author_id=emp8.id,
        storage_period=365
    )

    doc5 = document(
        number="СЗ-005/23",
        created_at=datetime(2023, 5, 18),
        type_id=type_objs[2].id,
        status_id=status_objs[3].id,
        author_id=emp3.id,
        storage_period=365
    )

    doc6 = document(
        number="АКТ-006/23",
        created_at=datetime(2023, 3, 20),
        type_id=type_objs[4].id,    # Акт
        status_id=status_objs[6].id,  # Исполнен
        author_id=emp5.id,
        storage_period=1095
    )

    doc7 = document(
        number="ОТЧ-007/23",
        created_at=datetime(2023, 4, 25),
        type_id=type_objs[7].id,    # Отчет
        status_id=status_objs[2].id,  # Согласован
        author_id=emp10.id,
        storage_period=1825
    )

    doc8 = document(
        number="ПР-008/23",
        created_at=datetime(2023, 11, 1),
        type_id=type_objs[0].id,
        status_id=status_objs[1].id,  # На согласовании
        author_id=emp1.id,
        storage_period=3650
    )

    session.add_all([doc1, doc2, doc3, doc4, doc5, doc6, doc7, doc8])
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

    # 8. Движение документов и согласования (реальные цепочки)
    # -----------------------
    print("\n8. Добавляем движение документов и согласования")

    # 1. ПР-001/23 — Приказ от Смирнова (гендир), утверждён Кузнецовой
    flow1 = documentflow(
        document_id=doc1.id,
        sender_id=emp1.id,      # Смирнов → Кузнецова
        receiver_id=emp2.id,
        sent_at=datetime(2023, 1, 15, 14, 30),
        status="Отправлено на утверждение"
    )
    approval1 = approval(
        document_id=doc1.id,
        employee_id=emp2.id,
        approval_date=datetime(2023, 1, 16, 11, 20),
        comment="Утверждено"
    )

    # 2. ДГ-002/23 — Договор от Лебедевой (IT), проходит юр.отдел → бухгалтерия → утверждение гендиром
    flow2a = documentflow(document_id=doc2.id, sender_id=emp9.id, receiver_id=emp7.id,  # Лебедева → Николаева (юрист)
                          sent_at=datetime(2023, 2, 10, 15, 00), status="На согласовании")
    approval2a = approval(document_id=doc2.id, employee_id=emp7.id,
                     approval_date=datetime(2023, 2, 11, 10, 15), comment="Юридически корректно")

    flow2b = documentflow(document_id=doc2.id, sender_id=emp7.id, receiver_id=emp5.id,  # Николаева → Сидорова (бухгалтер)
                          sent_at=datetime(2023, 2, 11, 11, 00), status="На согласовании")
    approval2b = approval(document_id=doc2.id, employee_id=emp5.id,
                          approval_date=datetime(2023, 2, 12, 14, 45), comment="Финансовые условия приемлемы")

    flow2c = documentflow(document_id=doc2.id, sender_id=emp5.id, receiver_id=emp1.id,  # Сидорова → Смирнов (на утверждение)
                          sent_at=datetime(2023, 2, 12, 15, 30), status="На утверждение")
    approval2c = approval(document_id=doc2.id, employee_id=emp1.id,
                          approval_date=datetime(2023, 2, 13, 9, 10), comment="Утверждаю")

    # 3. ПР-003/23 — Ещё один приказ от Смирнова → сразу утверждён
    flow3 = documentflow(document_id=doc3.id, sender_id=emp1.id, receiver_id=emp2.id,
                         sent_at=datetime(2023, 10, 5, 16, 00), status="Отправлено на утверждение")
    approval3 = approval(document_id=doc3.id, employee_id=emp2.id,
                         approval_date=datetime(2023, 10, 6, 10, 30), comment="Утверждено")

    # 4. СЗ-004/23 — Служебка от Волкова (IT) → сейчас на согласовании у Николаевой (юрист)
    flow4 = documentflow(document_id=doc4.id, sender_id=emp8.id, receiver_id=emp7.id,
                         sent_at=datetime(2023, 9, 1, 11, 20), status="На согласовании")
    # Согласование ещё не получено → статус остаётся "На согласовании"

    # 5. СЗ-005/23 — Служебка от Ивановой (кадры) → согласована Сидоровой и утверждена Смирновым
    flow5a = documentflow(document_id=doc5.id, sender_id=emp3.id, receiver_id=emp5.id,
                          sent_at=datetime(2023, 5, 18, 10, 00), status="На согласовании")
    approval5a = approval(document_id=doc5.id, employee_id=emp5.id,
                          approval_date=datetime(2023, 5, 19, 13, 15), comment="Согласовано")

    flow5b = documentflow(document_id=doc5.id, sender_id=emp5.id, receiver_id=emp1.id,
                          sent_at=datetime(2023, 5, 19, 14, 00), status="На утверждение")
    approval5b = approval(document_id=doc5.id, employee_id=emp1.id,
                          approval_date=datetime(2023, 5, 20, 9, 45), comment="Утверждено")

    # 6. АКТ-006/23 — Акт от Сидоровой (бухгалтер), исполнен Федоровым
    flow6a = documentflow(document_id=doc6.id, sender_id=emp5.id, receiver_id=emp6.id,  # Сидорова → Федоров (исполнение)
                          sent_at=datetime(2023, 3, 20, 12, 00), status="На исполнение")
    flow6b = documentflow(document_id=doc6.id, sender_id=emp6.id, receiver_id=emp5.id,  # Федоров вернул как исполненный
                          sent_at=datetime(2023, 3, 25, 16, 30), status="Исполнено")
    approval6 = approval(document_id=doc6.id, employee_id=emp6.id,
                         approval_date=datetime(2023, 3, 25, 16, 30), comment="Работы выполнены в полном объёме")

    # 7. ОТЧ-007/23 — Отчёт от Козлова (продажи) → согласован Николаевой (юрист, т.к. затрагивает договоры)
    flow7 = documentflow(document_id=doc7.id, sender_id=emp10.id, receiver_id=emp7.id,
                         sent_at=datetime(2023, 4, 25, 17, 00), status="На согласовании")
    approval7 = approval(document_id=doc7.id, employee_id=emp7.id,
                         approval_date=datetime(2023, 4, 26, 11, 10), comment="Замечаний нет")

    # 8. ПР-008/23 — Новый приказ от Смирнова, только что создан, отправлен на согласование в юр.отдел и бухгалтерию
    flow8a = documentflow(document_id=doc8.id, sender_id=emp1.id, receiver_id=emp7.id,
                          sent_at=datetime(2023, 11, 1, 14, 00), status="На согласовании")
    flow8b = documentflow(document_id=doc8.id, sender_id=emp1.id, receiver_id=emp5.id,
                          sent_at=datetime(2023, 11, 1, 14, 5), status="На согласовании")
    # Пока без approval — документ висит "На согласовании"

    # Добавляем всё в базу
    session.add_all([
        # doc1
        flow1, approval1,
        # doc2
        flow2a, approval2a, flow2b, approval2b, flow2c, approval2c,
        # doc3
        flow3, approval3,
        # doc4
        flow4,
        # doc5
        flow5a, approval5a, flow5b, approval5b,
        # doc6
        flow6a, flow6b, approval6,
        # doc7
        flow7, approval7,
        # doc8
        flow8a, flow8b
    ])
    session.commit()

print("База данных успешно заполнена минимальными данными!")
