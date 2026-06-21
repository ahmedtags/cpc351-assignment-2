# CPC351 - Principles of Data Analytics (Assignment 2)

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
