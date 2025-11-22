# services/requests.py
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Фикс импорта

from sqlmodel import Session, select
from db import engine
from models.tables import (
    document, employee, documentflow, approval,
    dtype, dstatus, role, department
)

# === Основные процессы предметной области ===

def get_all_documents():
    """1. Получить все документы"""
    with Session(engine) as session:
        return session.exec(select(document)).all()


def get_documents_by_author(author_id: int):
    """2. Документы конкретного автора"""
    with Session(engine) as session:
        return session.exec(
            select(document).where(document.author_id == author_id)
        ).all()


def get_document_history(doc_id: int):
    """3. История движения документа"""
    with Session(engine) as session:
        return session.exec(
            select(documentflow)
            .where(documentflow.document_id == doc_id)
            .order_by(documentflow.sent_at)
        ).all()


def get_approvals_for_document(doc_id: int):
    """4. Согласования по документу"""
    with Session(engine) as session:
        return session.exec(
            select(approval)
            .where(approval.document_id == doc_id)
            .order_by(approval.approval_date)
        ).all()


def get_documents_on_approval():
    """5. Документы, находящиеся на согласовании"""
    with Session(engine) as session:
        status = session.exec(
            select(dstatus).where(dstatus.name == "на согласовании")
        ).first()
        if not status:
            return []
        return session.exec(
            select(document).where(document.status_id == status.id)
        ).all()


def get_employee_role(employee_id: int):
    """6. Роль сотрудника"""
    with Session(engine) as session:
        emp = session.get(employee, employee_id)
        if not emp:
            return None
        return session.get(role, emp.role_id)


def get_department_head(department_id: int):
    """7. Руководитель подразделения"""
    with Session(engine) as session:
        dept = session.get(department, department_id)
        if not dept or not dept.head_id:
            return None
        return session.get(employee, dept.head_id)