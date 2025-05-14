# dbt Project

This project contains the code for a dbt (data build tool) transformation workflow.

## Project Structure

### models/

- **staging/**  
  Contains the source models. In this folder, you can find the source tables and some tests related to them.

- **marts/**  
  Contains the core business logic, including all dimension and fact tables. Tests have been added specifically for the fact tables.

### tests/

- This folder contains custom tests created for the project.  
  A key custom test included here checks for **valid dates** across relevant models.

## Notes

- dbt is used to manage transformations in the analytics engineering workflow.
- The structure separates raw source models (staging) from business logic (marts).
- Custom data quality checks enhance the reliability of outputs, particularly around date validity.

