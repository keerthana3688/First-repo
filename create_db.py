import sqlite3

data = [
    ("Widget A", 10, 2.5, "2025-09-01"),
    ("Widget B", 5,  4.0, "2025-09-01"),
    ("Widget A", 3,  2.5, "2025-09-02"),
    ("Widget C", 8,  1.75,"2025-09-02"),
    ("Widget B", 7,  4.0, "2025-09-03"),
    ("Widget A", 2,  2.5, "2025-09-03"),
]

conn = sqlite3.connect("sales_data.db")
cur = conn.cursor()

cur.execute("""
CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    price REAL NOT NULL,
    sale_date TEXT
);
""")

cur.executemany("INSERT INTO sales (product, quantity, price, sale_date) VALUES (?, ?, ?, ?);", data)
conn.commit()
conn.close()

print("✅ Created sales_data.db and inserted sample rows.")