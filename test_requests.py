# test_requests.py
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent))  # Корень проекта

from services.requests import (
    get_all_documents,
    get_documents_by_author,
    get_document_history,
    get_approvals_for_document,
    get_documents_on_approval,
    get_employee_role,
    get_department_head
)

print("=== Проверка пункта 6 ===")

# 1. Все документы
print("\n1. Все документы:")
docs = get_all_documents()
for d in docs:
    print(f"   • {d.number} (автор: {d.author_id})")

# 2. Документы автора (Иван — id=1)
print("\n2. Документы автора (id=1):")
docs = get_documents_by_author(1)
for d in docs:
    print(f"   • {d.number}")

# 3. История движения документа (id=1)
print("\n3. История движения документа (id=1):")
flow = get_document_history(1)
for f in flow:
    print(f"   • От {f.sender_id} → {f.receiver_id}, статус: {f.status}")

# 4. Согласования по документу (id=1)
print("\n4. Согласования по документу (id=1):")
apps = get_approvals_for_document(1)
for a in apps:
    print(f"   • {a.employee_id}: {a.comment}")

# 5. Документы на согласовании
print("\n5. Документы на согласовании:")
on_approval = get_documents_on_approval()
for d in on_approval:
    print(f"   • {d.number}")

# 6. Роль сотрудника (id=1)
print("\n6. Роль сотрудника (id=1):")
role = get_employee_role(1)
if role:
    print(f"   • {role.name}")

# 7. Руководитель отдела (id=1)
print("\n7. Руководитель отдела (id=1):")
head = get_department_head(1)
if head:
    print(f"   • {head.full_name}")