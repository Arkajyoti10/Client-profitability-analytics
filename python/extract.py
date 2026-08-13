import os
from pathlib import Path
from dotenv import load_dotenv
from urllib.parse import quote_plus
from sqlalchemy import create_engine,text
import pandas as pd

BASE_DIR=Path(__file__).resolve().parent.parent

#store database data
load_dotenv(BASE_DIR/".env")

DB_HOST=os.getenv("DB_HOST")
DB_PORT=os.getenv("DB_PORT")
DB_NAME=os.getenv("DB_NAME")
DB_USER=os.getenv("DB_USER")
DB_PASSWORD=os.getenv("DB_PASSWORD")
Database="Client_profitability_analysis"

#read the sql query
sql_path=BASE_DIR / "sql" / "profits" / "profitability_analysis.sql"
with open(sql_path, "r") as f:
    query=f.read()

#load the postgresql engine
Safe_password=quote_plus(DB_PASSWORD)
connection_string=f"postgresql://{DB_USER}:{Safe_password}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
engine=create_engine(connection_string)

def get_client_profitability() -> pd.DataFrame:
    try:
        df=pd.read_sql(text(query),engine)
    except:
        raise RuntimeError(f"Failed")
    return df

if __name__=="__main__":
    df=get_client_profitability()
    print(df.head())