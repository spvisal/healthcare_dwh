import json
import pandas as pd


class ClinicalDataFlattener:
    def __init__(self, json_data):
        self.data = json_data
        self.rows = []

    def flatten(self):
        for patient in self.data:
            patient_id = patient["patient_id"]
            patient_name = patient["name"]

            for visit in patient["visits"]:
                visit_id = visit["visit_id"]
                visit_date = visit["date"]
                provider_notes = visit.get("provider_notes", {}).get("text")
                provider_name = visit.get("provider_notes", {}).get("author")

                for diagnosis in visit["diagnoses"]:
                    diagnosis_code = diagnosis["code"]
                    diagnosis_desc = diagnosis["description"]

                    for treatment in diagnosis["treatments"]:
                        row = {
                            "patient_id": patient_id,
                            "patient_name": patient_name,
                            "visit_id": visit_id,
                            "visit_date": visit_date,
                            "diagnosis_code": diagnosis_code,
                            "diagnosis_desc": diagnosis_desc,
                            "drug": treatment["drug"],
                            "dose": treatment["dose"],
                            "provider_notes": provider_notes,
                            "provider_name": provider_name
                        }
                        self.rows.append(row)

        return pd.DataFrame(self.rows)
