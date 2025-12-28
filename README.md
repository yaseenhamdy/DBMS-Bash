# Bash DBMS Project for ITI

## 📌 Overview
This project is a **Database Management System (DBMS) implemented entirely using Bash scripting**.  
It simulates basic database operations using directories and files on the Linux filesystem.

The project aims to:
- Understand core DBMS concepts
- Practice Bash scripting (functions, loops, arrays, regex)
- Implement SQL-like commands using regular expressions
- Build a menu-driven CLI application

---

## 🧠 How the DBMS Works
- Each **Database** is represented as a directory inside `Databases/`
- Each **Table** consists of:
  - A `.SQL` file → stores table data
  - A hidden `.table_name.SQL` file → stores table metadata (columns, data types, primary key)
- SQL-like commands are parsed using **regex**
- All logic is implemented using Bash scripts only

---

## ▶️ How to Run the Project
1. Make sure you are using a Linux system with Bash
2. Give execution permission:
```bash
   chmod +x main.sh
   ./main.sh
```

---

## 📂 Project Structure   
```
BASH_TASK/
│
├── main.sh
├── README.md
├── .gitignore
│
├── Databases/
│   └── (Created databases will appear here)
│
├── database_func/
│   ├── create_database.sh
│   ├── create_db_regex.sh
│   ├── list_database.sh
│   ├── connect_to_database.sh
│   ├── connect_to_db_regex.sh
│   ├── drop_database.sh
│   └── drop_database_regex.sh
│
└── table_func/
    ├── table_menu.sh
    ├── create_table.sh
    ├── drop_table.sh
    ├── list_tables.sh
    ├── listing_columns.sh
    ├── insert_into_table.sh
    ├── select_from_table.sh
    ├── update_table.sh
    ├── delete_from_table.sh
    └── add_column.sh
```

---

## 🧩 File Responsibilities

### 🔹 main.sh
- Entry point of the application
- Displays the main menu
- Handles navigation between database operations
- Supports Wizard-based and SQL-based commands

---

## 🗄️ Database Functions (`database_func/`)

| File | Description |
|------|-------------|
| `create_database.sh` | Create a database using interactive wizard |
| `create_db_regex.sh` | Create database using SQL (`CREATE DATABASE db;`) |
| `list_database.sh` | List all available databases |
| `connect_to_database.sh` | Connect to database using wizard |
| `connect_to_db_regex.sh` | Connect using SQL (`USE db;`) |
| `drop_database.sh` | Drop database using wizard |
| `drop_database_regex.sh` | Drop database using SQL (`DROP DATABASE db;`) |

---

## 📋 Table Functions (`table_func/`)

| File | Description |
|------|-------------|
| `table_menu.sh` | Table management menu |
| `create_table.sh` | Create a new table |
| `drop_table.sh` | Drop a table |
| `list_tables.sh` | List all tables |
| `listing_columns.sh` | Show table columns and metadata |
| `insert_into_table.sh` | Insert data into a table |
| `select_from_table.sh` | Select records (with or without filters) |
| `update_table.sh` | Update table records |
| `delete_from_table.sh` | Delete records from table |
| `add_column.sh` | Add a new column to a table |

---

## 🧪 Supported SQL-like Commands

### 🗃️ Database Level
- `CREATE DATABASE db_name;`
- `USE db_name;`
- `DROP DATABASE db_name;`

### 📊 Table Level
- Create table
- Insert records
- Select specific columns
- Filter records
- Update records
- Delete records

**Note:** All table operations are menu-driven

---

## 🤝 Collaborators

### Yaseen Hamdy
🔗 GitHub: [https://github.com/yaseenhamdy](https://github.com/yaseenhamdy)

### A'LAA Magdy
🔗 GitHub: [https://github.com/alaamagdy20211](https://github.com/alaamagdy20211)

---
