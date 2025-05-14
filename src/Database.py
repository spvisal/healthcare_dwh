from typing import Dict
from sqlalchemy import create_engine, text
from sqlalchemy.exc import OperationalError, SQLAlchemyError, DataError
import pandas as pd


class Database:
    def __init__(self, config: Dict):
        self.db_url = (f"postgresql+psycopg2://{config['user']}:"
                       f"{config['password']}@{config['host']}:{config['port']}/{config['dbname']}")
        self.engine = None
        self.conn = None

    def connect(self):
        try:
            self.engine = create_engine(self.db_url)
            self.conn = self.engine.connect()
        except OperationalError as err:
            print(f"Cannot connect to Db: {err}")
            raise err

    def insert_data(self, table_name, df):
        """Insert data into the database using provided query and data"""
        try:
            df.to_sql(
                table_name,
                self.conn,
                if_exists='append',
                index=False
            )
            print(f"Finish inserting records in {table_name}")

        except DataError as err:
            print(f"Incorrect data: {err}")
            raise err
        except OperationalError as err:
            print(f"Cannot connect to Db: {err}")
            raise err
        except SQLAlchemyError as err:
            print("Unexpected SQLAlchemy error: %s", err)
            raise err

    def close(self):
        """Close the database connection"""
        if self.conn:
            self.conn.close()
            print("Database connection closed.")

    def create_tables(self, create_table_queries):
        """Create tables in the database using provided SQL queries"""
        try:
            for query in create_table_queries:
                self.conn.execute(text(query))
            print("Finished creating all the required tables.")
        except Exception as e:
            print(f"Encountered an issue while creating tables: {e}")

    def drop_tables(self, drop_table_queries):
        try:
            for query in drop_table_queries:
                self.conn.execute(text(query))
            print("Finished dropping all the tables.")
        except Exception as e:
            print(f"Encountered an issue while creating tables: {e}")
