from sqlmodel import SQLModel, Field, MetaData
from typing import Optional
from datetime import datetime

SCHEMA = "Peturova"  #  схема в базе данных

class Base(SQLModel, table=False):
    metadata = MetaData(schema="Peturova")

# Таблица типов документов
class dtype(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str = Field(alias="name")
    description: Optional[str] = Field(default=None, alias="description")

# Таблица статусов документов
class dstatus(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str = Field(alias="name")

# Таблица ролей
class role(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str = Field(alias="name")

# Таблица подразделений
class department(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str = Field(alias="name")
    head_id: Optional[int] = Field(default=None, foreign_key=f"{SCHEMA}.employee.id", alias="head_id")

# Таблица сотрудников
class employee(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    full_name: str = Field(alias="full_name")
    role_id: int = Field(foreign_key=f"{SCHEMA}.role.id", alias="role_id")
    department_id: int = Field(foreign_key=f"{SCHEMA}.department.id", alias="department_id")
    contact_info: Optional[str] = Field(default=None, alias="contact_info")

# Таблица документов
class document(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    number: str = Field(alias="number")
    created_at: datetime = Field(alias="created_at")
    type_id: int = Field(foreign_key=f"{SCHEMA}.dtype.id", alias="type_id")
    status_id: int = Field(foreign_key=f"{SCHEMA}.dstatus.id", alias="status_id")
    author_id: int = Field(foreign_key=f"{SCHEMA}.employee.id", alias="author_id")
    storage_period: Optional[int] = Field(default=None, alias="storage_period")  # срок хранения в днях

# Таблица движения документа
class documentflow(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    document_id: int = Field(foreign_key=f"{SCHEMA}.document.id", alias="document_id")
    sender_id: int = Field(foreign_key=f"{SCHEMA}.employee.id", alias="sender_id")
    receiver_id: int = Field(foreign_key=f"{SCHEMA}.employee.id", alias="receiver_id")
    sent_at: datetime = Field(alias="sent_at")
    status: str = Field(alias="status")

# Таблица согласований
class approval(Base, table=True):
    # __table_args__ = {"schema": SCHEMA}
    id: Optional[int] = Field(default=None, primary_key=True)
    document_id: int = Field(foreign_key=f"{SCHEMA}.document.id", alias="document_id")
    employee_id: int = Field(foreign_key=f"{SCHEMA}.employee.id", alias="employee_id")
    approval_date: Optional[datetime] = Field(default=None, alias="approval_date")
    comment: Optional[str] = Field(default=None, alias="comment")
