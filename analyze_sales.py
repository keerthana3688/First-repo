import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

# Connect to the database
conn = sqlite3.connect("sales_data.db")

# SQL query
query = """
SELECT
  product,
  SUM(quantity) AS total_qty,
  SUM(quantity * price) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC;
"""

# Load results into pandas
df = pd.read_sql_query(query, conn)

# Print results
print("Sales summary per product:")
print(df.to_string(index=False))

# Totals
print("\nTOTAL quantity sold:", df['total_qty'].sum())
print("TOTAL revenue:", df['revenue'].sum())

# Plot chart
df.plot(kind="bar", x="product", y="revenue", legend=False)
plt.xlabel("Product")
plt.ylabel("Revenue")
plt.title("Revenue by Product")
plt.tight_layout()
plt.savefig("sales_chart.png")   # saves chart as PNG
plt.show()

conn.close()