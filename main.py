
from sqlmodel import SQLModel, Session, select
from typing import List
from datetime import datetime
from db import engine
from models.tables import document, employee, dtype, dstatus, role, department, documentflow, approval

from fastapi import FastAPI, HTTPException , status
from services.requests import (
    get_all_documents, get_documents_by_author,
    get_document_history, get_approvals_for_document,
    get_documents_on_approval, get_employee_role,
    get_department_head
)

app = FastAPI(
    title="Система электронного документооборота",
    description="Петурова Надежда Игоревна",
    version="2.0"
)


# ====================== GET-эндпоинты (чтение) ======================

@app.get("/")
def root():
    return {"message": "API документооборота запущено! Документация: /docs"}

@app.get("/documents", response_model=List[document])
def read_documents():
    """Все документы"""
    return get_all_documents()

@app.get("/documents/author/{author_id}", response_model=List[document])
def read_documents_by_author(author_id: int):
    """Документы автора"""
    docs = get_documents_by_author(author_id)
    if not docs:
        raise HTTPException(status_code=404, detail="Документы не найдены")
    return docs

@app.get("/documents/{doc_id}/history", response_model=List[documentflow])
def read_document_history(doc_id: int):
    """История движения документа"""
    history = get_document_history(doc_id)
    if not history:
        raise HTTPException(status_code=404, detail="История движения не найдена")
    return history

@app.get("/documents/{doc_id}/approvals", response_model=List[approval])
def read_document_approvals(doc_id: int):
    """Согласования по документу"""
    approvals = get_approvals_for_document(doc_id)
    if not approvals:
        raise HTTPException(status_code=404, detail="Согласования не найдены")
    return approvals

@app.get("/documents/on-approval", response_model=List[document])
def read_documents_on_approval():
    """Документы на согласовании"""
    return get_documents_on_approval()


# ====================== POST — создание ======================

@app.post("/documents", response_model=document, status_code=status.HTTP_201_CREATED)
def create_document(doc: document):
    """Создать новый документ"""
    with Session(engine) as session:
        # Автоматически ставим статус "в работе"
        if not doc.status_id:
            status_obj = session.exec(select(dstatus).where(dstatus.name == "в работе")).first()
            if status_obj:
                doc.status_id = status_obj.id
        
        doc.created_at = datetime.utcnow() if doc.created_at is None else doc.created_at
        session.add(doc)
        session.commit()
        session.refresh(doc)
        return doc

@app.post("/documentflow", response_model=documentflow, status_code=status.HTTP_201_CREATED)
def send_document(flow: documentflow):
    """Отправить документ на согласование/исполнение"""
    with Session(engine) as session:
        flow.sent_at = datetime.utcnow()
        session.add(flow)
        session.commit()
        session.refresh(flow)

        # При отправке меняем статус документа на "на согласовании"
        doc = session.get(document, flow.document_id)
        if doc:
            status_obj = session.exec(select(dstatus).where(dstatus.name == "на согласовании")).first()
            if status_obj:
                doc.status_id = status_obj.id
                session.add(doc)
                session.commit()
        return flow

@app.post("/approvals", response_model=approval, status_code=status.HTTP_201_CREATED)
def approve_document(approval_data: approval):
    """Согласовать документ"""
    with Session(engine) as session:
        approval_data.approval_date = datetime.utcnow()
        session.add(approval_data)
        session.commit()
        session.refresh(approval_data)

        # Меняем статус документа в зависимости от результата
        doc = session.get(document, approval_data.document_id)
        if doc and hasattr(approval_data, "result") and approval_data.result:
            if approval_data.result == "согласовано":
                new_status = session.exec(select(dstatus).where(dstatus.name == "утверждён")).first()
            elif approval_data.result in ["отклонено", "на доработке"]:
                new_status = session.exec(select(dstatus).where(dstatus.name == "на доработке")).first()
            else:
                new_status = None

            if new_status:
                doc.status_id = new_status.id
                session.add(doc)
                session.commit()

        return approval_data


# ====================== PUT — обновление ======================

@app.put("/documents/{doc_id}", response_model=document)
def update_document(doc_id: int, updated_data: document):
    with Session(engine) as session:
        db_doc = session.get(document, doc_id)
        if not db_doc:
            raise HTTPException(status_code=404, detail="Документ не найден")

        update_dict = updated_data.dict(exclude_unset=True)
        for key, value in update_dict.items():
            setattr(db_doc, key, value)

        session.add(db_doc)
        session.commit()
        session.refresh(db_doc)
        return db_doc


# ====================== DELETE ======================

@app.delete("/documents/{doc_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_document(doc_id: int):
    with Session(engine) as session:
        doc = session.get(document, doc_id)
        if not doc:
            raise HTTPException(status_code=404, detail="Документ не найден")
        session.delete(doc)
        session.commit()
    return None


# ====================== Справочники ======================

@app.get("/employee/{emp_id}/role", response_model=List[role])
def get_employee_role(emp_id: int):
    """Роль сотрудника"""
    role = get_employee_role(emp_id)
    if not role:
        raise HTTPException(status_code=404, detail="Сотрудник или роль не найдены")
    return {"id": role.id, "name": role.name}

@app.get("/department/{dept_id}/head", response_model=List[department])
def get_department_head(dept_id: int):
    """Руководитель подразделения"""
    head = get_department_head(dept_id)
    if not head:
        raise HTTPException(status_code=404, detail="Руководитель не найден")
    return {"id": head.id, "full_name": head.full_name}

@app.get("/roles", response_model=List[role])
def get_roles():
    """Все роли в системе"""
    with Session(engine) as session:
        return session.exec(select(role)).all()

@app.get("/departments", response_model=List[department])
def get_departments():
    """Все подразделения"""
    with Session(engine) as session:
        return session.exec(select(department)).all()

@app.get("/statuses", response_model=List[dstatus])
def get_statuses():
    """Все возможные статусы документа"""
    with Session(engine) as session:
        return session.exec(select(dstatus)).all()

@app.get("/employees", response_model=List[employee])
def get_employees():
    """Все сотрудники (удобно для выпадающих списков)"""
    with Session(engine) as session:
        return session.exec(select(employee)).all()

@app.get("/document-types", response_model=List[dtype])
def get_document_types():
    """Все типы документов"""
    with Session(engine) as session:
        return session.exec(select(dtype)).all()