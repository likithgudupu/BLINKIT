# 🛒 Blinkit Sales Dashboard (Power BI Project)

This project presents a comprehensive sales analysis dashboard for Blinkit using Power BI and SQL. The dashboard highlights key performance metrics, sales trends, and item-level insights to aid business decision-making.

---

## 📂 Project Contents

| File | Description |
|------|-------------|
| `blinkit.pbix` | Power BI dashboard project file |
| `Blinkit data.sql` | SQL script for data preparation and cleaning |
| `Screenshot 2025-07-30 114350.png` | Screenshot of the Power BI dashboard |

---

## 🧠 Insights Covered

The dashboard provides the following analytics:

- 📦 **Total Sales**: ₹1.20M across 8,523 items
- ⭐ **Average Rating**: 3.92
- 🛍️ **Sales by Item Type**: Highlights top-selling categories like Fruits & Vegetables, Snack Foods, etc.
- 🏪 **Sales by Outlet Type and Size**: Comparison across Grocery Stores and different supermarket types
- 📅 **Sales by Establishment Year**: Tracks performance of outlets over time
- 🧁 **Fat Content Analysis**: Sales split between Low Fat and Regular items
- ⚖️ **Average Item Weight**: Displayed by item category

---

## 🧰 Tools & Technologies Used

- **Power BI**: For data visualization and interactive reporting  
- **SQL (MySQL)**: For data cleaning, transformation, and aggregation  
- **Microsoft Excel** *(optional)*: For initial data review and import  
- **Power BI DAX**: For calculated fields and measures  

---

## ⚙️ How to Use

1. **Open `blinkit.pbix`** in Power BI Desktop  
2. Ensure your SQL data is connected properly (or load the final Excel/CSV if used)  
3. Explore visuals using slicers for year, outlet type, and fat content  
4. Modify and extend the dashboard as needed for your own analysis  

---

## 📸 Dashboard Preview

![Dashboard Preview]<img width="1328" height="739" alt="Screenshot 2026-02-12 204631" src="https://github.com/user-attachments/assets/02ca0e62-e32d-4244-be21-ffe1de0db12a" />
()

---

## 📜 Sample SQL Queries Used

```sql
-- Sum of Sales by Item Fat Content
SELECT `Item Fat Content`, SUM(`Total Sales`) AS Total_Sales
FROM blinkit_db.blinkit_data
GROUP BY `Item Fat Content`;

-- Sales by Item Type
SELECT `Item Type`, SUM(`Total Sales`) AS Total_Sales
FROM blinkit_db.blinkit_data
GROUP BY `Item Type`;
