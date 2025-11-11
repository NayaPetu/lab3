
from sqlmodel import SQLModel, Session, select
from db import engine
from models.tables import document, employee, dtype, dstatus, role, department, documentflow, approval

# # --- Работа с данными ---
# def get_documents():
#     with Session(engine) as session:
#         statement = select(document)
#         results = session.exec(statement).all()
#         return results

# def get_authors():
#     with Session(engine) as session:
#         statement = select(employee)
#         results = session.exec(statement).all()
#         return results

# if __name__ == "__main__":
#     print("Список документов:", get_documents())


# main.py
# import sys
# from pathlib import Path
# sys.path.append(str(Path(__file__).parent))  # Фикс импорта

from fastapi import FastAPI, HTTPException
from services.requests import (
    get_all_documents, get_documents_by_author,
    get_document_history, get_approvals_for_document,
    get_documents_on_approval, get_employee_role,
    get_department_head
)

app = FastAPI(
    title="Система документооборота",
    description="Лабораторная работа №3",
    version="1.0"
)

@app.get("/")
def root():
    return {"message": "API документооборота запущено!"}

@app.get("/documents")
def documents():
    """Все документы"""
    return get_all_documents()

@app.get("/documents/author/{author_id}")
def documents_by_author(author_id: int):
    """Документы автора"""
    docs = get_documents_by_author(author_id)
    if not docs:
        raise HTTPException(status_code=404, detail="Документы не найдены")
    return docs

@app.get("/documents/{doc_id}/flow")
def document_flow(doc_id: int):
    """История движения документа"""
    flow = get_document_history(doc_id)
    if not flow:
        raise HTTPException(status_code=404, detail="Движение не найдено")
    return flow

@app.get("/documents/{doc_id}/approvals")
def document_approvals(doc_id: int):
    """Согласования по документу"""
    approvals = get_approvals_for_document(doc_id)
    if not approvals:
        raise HTTPException(status_code=404, detail="Согласования не найдены")
    return approvals

@app.get("/documents/on-approval")
def on_approval():
    """Документы на согласовании"""
    return get_documents_on_approval()

@app.get("/employee/{emp_id}/role")
def employee_role(emp_id: int):
    """Роль сотрудника"""
    role = get_employee_role(emp_id)
    if not role:
        raise HTTPException(status_code=404, detail="Сотрудник или роль не найдены")
    return {"id": role.id, "name": role.name}

@app.get("/department/{dept_id}/head")
def department_head(dept_id: int):
    """Руководитель подразделения"""
    head = get_department_head(dept_id)
    if not head:
        raise HTTPException(status_code=404, detail="Руководитель не найден")
    return {"id": head.id, "full_name": head.full_name}