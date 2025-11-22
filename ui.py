# ui.py — КРАСИВЫЙ ВЕБ-ИНТЕРФЕЙС ДЛЯ ТВОЕГО API
import streamlit as st
import requests
from datetime import datetime

# Настройка страницы
st.set_page_config(page_title="ЭДО — Документооборот", layout="wide")
st.title("Система электронного документооборота")
st.markdown("Лабораторная работа №4 — Надя (лучшая на потоке)")

API_URL = "http://127.0.0.1:8000"

# Боковая панель
st.sidebar.header("Навигация")
page = st.sidebar.radio("Перейти к:", [
    "Все документы",
    "Мои документы",
    "Создать документ",
    "Отправить на согласование",
    "Согласовать документ",
    "Справочники"
])

# ====================== СТРАНИЦЫ ======================

if page == "Все документы":
    st.header("Все документы в системе")
    docs = requests.get(f"{API_URL}/documents").json()
    if docs:
        for d in docs:
            with st.expander(f"№{d['number']} — {d.get('type_name', 'Неизвестно')}"):
                st.write(f"Автор: {d.get('author_name', '—')}")
                st.write(f"Статус: **{d.get('status_name', '—')}**")
                st.write(f"Создан: {d['created_at'][:10] if d['created_at'] else '—'}")
    else:
        st.info("Документов пока нет")

elif page == "Мои документы":
    st.header("Мои документы")
    author_id = st.number_input("Ваш ID сотрудника", min_value=1, value=1)
    if st.button("Показать"):
        docs = requests.get(f"{API_URL}/documents/author/{author_id}").json()
        if docs:
            for d in docs:
                st.success(f"№{d['number']} — {d.get('status_name', '')}")
        else:
            st.warning("У вас нет документов")

elif page == "Создать документ":
    st.header("Создать новый документ")
    with st.form("create_doc"):
        number = st.text_input("Номер документа", "001/25")
        type_id = st.selectbox("Тип", options=[1,2,3,4], format_func=lambda x: ["Приказ", "Служебная записка", "Договор", "Распоряжение"][x-1])
        author_id = st.number_input("ID автора", value=1)
        storage = st.number_input("Срок хранения (дней)", value=365)
        submit = st.form_submit_button("Создать")
        if submit:
            data = {"number": number, "type_id": type_id, "author_id": author_id, "storage_period": storage}
            r = requests.post(f"{API_URL}/documents", json=data)
            if r.status_code == 201:
                st.success("Документ создан!")
                st.balloons()
            else:
                st.error("Ошибка создания")

elif page == "Отправить на согласование":
    st.header("Отправить документ")
    doc_id = st.number_input("ID документа", min_value=1)
    sender_id = st.number_input("От кого (ID)", value=1)
    receiver_id = st.number_input("Кому (ID)", value=2)
    if st.button("Отправить"):
        data = {"document_id": doc_id, "sender_id": sender_id, "receiver_id": receiver_id}
        r = requests.post(f"{API_URL}/documentflow", json=data)
        if r.status_code == 201:
            st.success("Документ отправлен на согласование!")
        else:
            st.error("Ошибка")

elif page == "Согласовать документ":
    st.header("Согласование")
    doc_id = st.number_input("ID документа для согласования", min_value=1)
    emp_id = st.number_input("Ваш ID", value=2)
    col1, col2 = st.columns(2)
    with col1:
        if st.button("согласовано"):
            data = {"document_id": doc_id, "employee_id": emp_id, "result": "согласовано", "comment": "Ок"}
            r = requests.post(f"{API_URL}/approvals", json=data)
            if r.status_code == 201:
                st.success("Документ утверждён!")
                st.balloons()
    with col2:
        if st.button("на доработке"):
            data = {"document_id": doc_id, "employee_id": emp_id, "result": "на доработке", "comment": "Исправить пункты 3 и 7"}
            r = requests.post(f"{API_URL}/approvals", json=data)
            if r.status_code == 201:
                st.warning("Отправлено на доработку")

elif page == "Справочники":
    st.header("Справочники")
    col1, col2 = st.columns(2)
    with col1:
        st.subheader("Сотрудники")
        emps = requests.get(f"{API_URL}/employees").json()
        for e in emps:
            st.write(f"{e['id']}. {e['full_name']} — {e.get('department_name', '')}")
    with col2:
        st.subheader("Отделы")
        depts = requests.get(f"{API_URL}/departments").json()
        for d in depts:
            st.write(f"{d['id']}. {d['name']}")
