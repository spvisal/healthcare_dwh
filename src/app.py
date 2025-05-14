from src.ClinicalDataFlattener import ClinicalDataFlattener
from src.Database import Database
import json
import os
from dotenv import load_dotenv

load_dotenv()

connection_details = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("USER"),
    "password": os.getenv("PASSWORD"),
    "host": os.getenv("HOST"),
    "port": os.getenv("PORT")
}

def check_file_exists(file_location):
    """Check if the provided file exists and read it"""
    try:
        if os.path.exists(file_location):
            return True
        raise FileNotFoundError(f"The file at {file_location} not found")

    except FileNotFoundError as e:
        print(f"Error: {e}")
        return False


if __name__ == "__main__":
    file_path = "../data/data.json"
    data = []
    response = check_file_exists(file_location=file_path)
    if response:
        with open(file_path, mode='r') as f:
            for line in f:
                data.append(json.loads(line.strip()))

    flattener = ClinicalDataFlattener(json_data=data)
    df = flattener.flatten()
    db = Database(config=connection_details)
    db.connect()
    db.insert_data(table_name='patients_visits', df=df)
    print("Flattened data saved to 'patients_visits' table.")
