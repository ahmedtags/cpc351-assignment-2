# CPC351 - Principles of Data Analytics (Assignment 2)

<p align="center">
  <img src="https://img.shields.io/badge/Language-Python%20(EDA)-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Language" />
  <img src="https://img.shields.io/badge/Course-CPC351-24292e?style=for-the-badge" alt="Course" />
  <a href="https://github.com/ahmedtags">
    <img src="https://img.shields.io/badge/Profile-ahmedtags-D9A34A?style=for-the-badge&logo=github&logoColor=white" alt="Profile" />
  </a>
  <a href="https://blxman-37fy.vercel.app/">
    <img src="https://img.shields.io/badge/Portfolio-blxman--37fy-0A66C2?style=for-the-badge&logo=googlechrome&logoColor=white" alt="Portfolio" />
  </a>
</p>

---

This repository contains the R programming implementation for **CPC351: Principles of Data Analytics - Assignment 2** (Semester 1, Academic Session 2025/2026) at Universiti Sains Malaysia (USM).

## Course Details
- **Course Code:** CPC351 / CPT351
- **Course Name:** Principles of Data Analytics
- **Semester:** Semester 1, Year 3 (2025/2026)

---

## Assignment Overview

The assignment involves a complete Exploratory Data Analysis (EDA) and visualization process on a nutrition dataset (`Food_Nutrition_Dataset.csv`). The script implements 17 data analytics and visualization tasks:

1. **Load Dataset:** Load the CSV and display structure/summary statistics.
2. **Missing Values Analysis:** Count and visualize missing values using bar charts.
3. **Food Categories Count:** Count unique food categories and show them in a bar chart.
4. **Caloric Rankings:** Identify the top 10 foods with the highest calories.
5. **Averaging Metrics:** Calculate the average calories, protein, carbs, and fat per category.
6. **Calorie Distribution:** Generate a histogram of calorie content across all foods.
7. **Grouped Boxplot:** Generate a boxplot of calories grouped by food category.
8. **Scatter Plot:** Plot calories vs. protein, color-coded by category.
9. **Correlation Heatmap:** Calculate and plot correlations among numeric columns (calories, protein, carbs, fat, iron, vitamin C).
10. **Vitamin C Content:** Identify the top 10 categories by average vitamin C.
11. **Outlier Detection (High Fat):** Find and visualize foods with fat content above the 95th percentile.
12. **Violin Plot:** Compare the distribution of carbs across three selected categories.
13. **Stacked Bar Chart:** Show total calories contributed by each category.
14. **Density Curve:** Plot a density curve for protein content across all foods.
15. **Bubble Chart:** Create a bubble chart where bubble size represents iron content, mapping calories vs. carbs.
16. **Nutrient Ratio Analysis:** Calculate the protein-to-calorie ratio, rank the top 10 foods, and plot a horizontal bar chart.
17. **Macronutrient Composition:** Analyze the composition of macronutrients across different categories.

---

## What I Did
- Implemented all 17 tasks in a clean R script: [`CPC351_ASSIGN2_SCRIPT.R`](CPC351_ASSIGN2_SCRIPT.R).
- Analyzed the dataset `Food_Nutrition_Dataset.csv`.
- Compiled the findings, charts, interpretations, and results into a comprehensive PDF report: [`CPC351_Assignment_2_Report_GROUP_25.pdf`](CPC351_Assignment_2_Report_GROUP_25.pdf).

---

## Tools & Tech Stack
- **Language:** R
- **IDE:** RStudio
- **Core Packages:** ggplot2 (for advanced visualizations), base R data frames and math utilities

---

## How to Run

1. Make sure you have R/RStudio installed on your machine.
2. Open [`CPC351_ASSIGN2_SCRIPT.R`](CPC351_ASSIGN2_SCRIPT.R) in RStudio.
3. Place `Food_Nutrition_Dataset.csv` in the same directory.
4. Set the working directory to the folder containing these files.
5. Install any required visualization packages (e.g., `ggplot2`, `corrplot` if used).
6. Run the script to generate all figures and numerical outputs.

---

## 📸 Sample Output

Here is the data summary and analytical outputs generated from `Food_Nutrition_Dataset.csv`:

### 1. Dataset Shape & Missing Values
- **Total Records:** 205 foods
- **Columns:** food_name, category, calories, protein, carbs, fat, iron, vitamin_c
- **Missing Values:** `iron` (2 missing), `vitamin_c` (3 missing)

### 2. Top Food Categories in Dataset
1. **Fruits and Fruit Juices:** 23 foods
2. **Vegetables and Vegetable Products:** 17 foods
3. **Cakes and pies:** 12 foods
4. **Yeast breads:** 11 foods
5. **Beverages:** 8 foods

### 3. Top 5 Foods with the Highest Calorie Content (per 100g)
1. **Garlic bread, frozen:** 1460.0 kcal
2. **PIZZA HUT, breadstick, parmesan garlic:** 1430.0 kcal
3. **Fast foods, breadstick, soft (garlic/parmesan):** 1430.0 kcal
4. **Mango, dried, sweetened:** 1340.0 kcal
5. **Blueberries, dried, sweetened:** 1330.0 kcal

### 4. Correlation Matrix of Macronutrients
| Nutrient | Calories | Protein | Carbs | Fat | Iron | Vitamin C |
|---|---|---|---|---|---|---|
| **Calories** | 1.000 | 0.412 | 0.580 | 0.363 | 0.372 | -0.105 |
| **Protein** | 0.412 | 1.000 | 0.303 | 0.344 | 0.712 | -0.151 |
| **Carbs** | 0.580 | 0.303 | 1.000 | 0.218 | 0.416 | -0.098 |
| **Fat** | 0.363 | 0.344 | 0.218 | 1.000 | 0.255 | -0.199 |

*Insight: Carb content has the highest correlation with calorie count (0.580), and protein is strongly correlated with iron content (0.712).*

### 5. High-Fat Outliers (> 95th Percentile = 24.5g)
- **Garlic sauce:** 74.02g fat
- **Onion dip, regular:** 35.77g fat
- **Bacon and tomato dressing:** 35.00g fat
- **Potato sticks, flavored:** 34.06g fat
- **Potato chips, plain:** 33.98g fat
