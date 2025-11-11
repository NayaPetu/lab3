from sqlmodel import create_engine

DATABASE_URL = "postgresql://student:mis2025!@176.108.247.125:5432/mis2025?options=-csearch_path=Peturova"
engine = create_engine(DATABASE_URL, echo=True)
