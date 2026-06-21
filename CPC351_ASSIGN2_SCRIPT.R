# Load libraries
library(ggplot2)
library(tidyverse) 


theme_set(
  theme_minimal() +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        margin = margin(b = 12)   # Space below title
      ),
      plot.margin = margin(12, 20, 12, 20), # Prevent clipping on all sides
      axis.title.x = element_text(margin = margin(t = 8)),
      axis.title.y = element_text(margin = margin(r = 8))
    )
)



## FIRST SET THE CURRENT WORKING DIRECTORY TO THE PLACE WHERE THE DATASET AND SCRIPT ARE

# ================================================================================
# 1. Load the dataset.
# ================================================================================



# Read the CSV files using read.csv() function
food_data <- read.csv("Food_Nutrition_Dataset.csv")

# Display structure and summary statistics
print("Dataset Structure:")
str(food_data)

print("Summary Statistics:")
summary(food_data)


#---------------------------------------------------------------------------------



# ================================================================================
# 2. Check for missing values in each column and visualize them using a bar chart
# ================================================================================



# Calculate missing values per column using colSums and is.na
missing_counts <- colSums(is.na(food_data))
print("Missing Values Count:")
print(missing_counts)

# Convert to data frame for plotting
missing_df <- data.frame(
  column_name = names(missing_counts),
  missing_count = as.numeric(missing_counts)
)

# Only plot if there are missing values, or plot all to show data quality
ggplot(missing_df, aes(x = reorder(column_name, -missing_count), y = missing_count)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "black") +
  labs(
    title = "Frequency of Missing Values per Column",
    x = "Variable Name",
    y = "Count of Missing Values"
  ) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, 12)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_text(aes(label = missing_count), vjust = -0.3, size = 3)

# Since missing/NA values have been determine, they must be removed from the data
food_data <- na.omit(food_data)

# Check the missing values again fo confirmation
print("Missing values count after NA values Removal:")
print(colSums(is.na(food_data)))



#---------------------------------------------------------------------------------



# ================================================================================
# 3. Count the number of unique food categories and display them in a bar chart
# ================================================================================

# Count the number of unique food categories using aggregate()
category_counts <- aggregate(food_name ~ category, data = food_data, FUN = length)
colnames(category_counts) <- c("category", "count")

# Sort in descending order
category_counts <- category_counts[order(-category_counts$count), ]

# Print the summary
print(category_counts)

# Create a bar chart
ggplot(category_counts, aes(x = reorder(category, -count), y = count)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "black") +
  labs(title = "Number of Foods per Category",
       x = "Food Category",
       y = "Number of Foods") +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, 10)) +
  theme(axis.text.x = element_text(angle = 70, hjust = 1)) +
  expand_limits(y = max(category_counts$count) * 1.1) +
  geom_text(aes(label = count), vjust = -0.3, size = 3) # labels for the bars

#---------------------------------------------------------------------------------


# ================================================================================
# 4. Find the top 10 foods with the highest calories
# ================================================================================

# Sort by calories and select top 10
food_data_sorted <- food_data[order(-food_data$calories), ]
top_10_calories <- food_data_sorted[1:10, c("food_name", "category", "calories")]

# Print the top 10 foods
print(top_10_calories)

# Create a bar chart
ggplot(top_10_calories, aes(x = reorder(food_name, -calories), y = calories, fill = category)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "Top 10 Foods with Highest Calories",
       x = "Food Name",
       y = "Calories (kcal)",
       fill = "Category") +
  coord_flip()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  geom_text(aes(label = calories), vjust = -0.3, size = 3)# labels for the bars

#---------------------------------------------------------------------------------


# ================================================================================
# 5. Calculate the average calories, protein, carbs, and fat per category
# ================================================================================

# Create list to store results
results <- list()

# Determine all unique categories
uniques <- unique(food_data$category)

for (a_category in uniques) {
  
  # Create a subset to store only the entries from the same category
  # Subset is cleared to fill in entries from the next category etc
  subset <- food_data[food_data$category == a_category, ]
  
  # Calculate the average for the nutritional columns of a category
  avg_calories <- mean(subset$calories)
  avg_protein <- mean(subset$protein)
  avg_carbs <- mean(subset$carbs)
  avg_fat <- mean(subset$fat)
  
  # Store the results as a named vector in the results list
  results[[a_category]] <- c(
    Average_Calories = avg_calories,
    Average_Protein = avg_protein,
    Average_Carbs = avg_carbs,
    Average_Fat = avg_fat
  )
}

# Use do.call(rbind, ...) to combine the list of results into a final data frame
final_results <- as.data.frame(do.call(rbind, results))

# Print the results
print(final_results)

#---------------------------------------------------------------------------------


# ================================================================================
# 6. Histogram of calories for all foods
# ================================================================================

ggplot(food_data, aes(x = calories)) +
  geom_histogram(bins = 30, fill = "#5da5da", color = "white", alpha = 0.8) +
  labs(title = "Calories for all foods",
       x = "Calories (kcal)",
       y = "Frequency") +
  theme_minimal()

#---------------------------------------------------------------------------------


# ================================================================================
# 7. Plot a boxplot of calories grouped by category
# ================================================================================

ggplot(food_data, aes(x = category, y = calories, fill = category)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Calories across Food Categories",
    x = "Food Category",
    y = "Calories (kcal)"
  ) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, 10)) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none" # Hide legend as x-axis labels are sufficient
  )

#---------------------------------------------------------------------------------


# ================================================================================
# 8. Create a scatter plot of calories vs protein, color-coded by category
# ================================================================================

# Create scatter plot
ggplot(food_data, aes(x = protein, y = calories, color = category)) + 
  geom_point(alpha = 0.6, size = 1.2) +
  labs(
    title = "Calories vs Protein by Food Category",
    x = "Protein (g)",
    y = "Calories (kcal)",
    color = "Food Category"
  ) +
  guides(color = guide_legend(ncol = 4, byrow = TRUE)) +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 8)
  )

#---------------------------------------------------------------------------------


# ================================================================================
# 9. Generate a correlation heatmap for numeric columns (calories, protein, 
#    carbs, fat, iron, vitamin_c)
# ================================================================================

# Select only the numeric columns for correlation analysis
numeric_data <- food_data[, c("calories", "protein", "carbs", "fat", "iron", "vitamin_c")]

# Calculate the correlation matrix
# "pairwise.complete.obs" is used to not include NA values in calculation
correlation_matrix <- cor(numeric_data, use = "pairwise.complete.obs")

# Melt the matrix into a long format data frame suitable for ggplot
# Melt transforms the matrix into rows of correlation of 2 numeric columns
# Do this only after installing the reshape2 package

corr_melted <- as.data.frame(correlation_matrix) %>%
  rownames_to_column("Var1") %>%
  pivot_longer(
    cols = -Var1,
    names_to = "Var2",
    values_to = "value"
  )

# Generate the heatmap
ggplot(corr_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "black") +
  coord_fixed() +
  geom_text(aes(label = round(value, 2)), color = "black", size = 4) +
  scale_fill_gradient2(
    low = "red", high = "blue", mid = "white",
    midpoint = 0, limit = c(-1, 1),
    name = "Correlation"
  ) +
  
  labs(title = "Correlation Heatmap of Numeric Columns", x = "", y = "")

#---------------------------------------------------------------------------------


# ================================================================================
# 10. Create a bar chart showing the top 10 categories by average vitamin C 
#     content
# ================================================================================

# Calculate average vitamin C per category using aggregate()
avg_vitamin_c <- aggregate(vitamin_c ~ category, data = food_data, FUN = mean, na.rm = TRUE)
colnames(avg_vitamin_c) <- c("category", "avg_vitamin_c")

# Sort in descending order and select top 10
avg_vitamin_c <- avg_vitamin_c[order(-avg_vitamin_c$avg_vitamin_c), ]
avg_vitamin_c_top10 <- avg_vitamin_c[1:10, ]

# Print the results
print(avg_vitamin_c_top10)

# Create a bar chart
ggplot(avg_vitamin_c_top10, aes(x = reorder(category, -avg_vitamin_c), y = avg_vitamin_c)) +
  geom_bar(stat = "identity", fill = "orange", color = "black") +
  labs(title = "Top 10 Categories by Average Vitamin C Content",
       x = "Food Category",
       y = "Average Vitamin C (mg)") +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, 12)) +
  expand_limits(y = max(avg_vitamin_c_top10$avg_vitamin_c) * 1.1) +
  theme(axis.text.x = element_text(angle = 70, hjust = 1)) +
  geom_text(aes(label = round(avg_vitamin_c, 2)), vjust = -0.3, size = 3)# labels for the bars

#---------------------------------------------------------------------------------


# ================================================================================
# 11. Identify foods with extremely high fat content (> 95th percentile)
# ================================================================================

fat_threshold <- quantile(food_data$fat, 0.95, na.rm = TRUE)

high_fat_foods <- food_data %>%
  filter(fat > fat_threshold) %>%
  arrange(desc(fat))

print(paste("95th Percentile for Fat:", round(fat_threshold, 2), "g"))
print("High Fat Foods:")
print(high_fat_foods %>% select(food_name, fat))

# Visualize high fat foods
ggplot(high_fat_foods, aes(x = reorder(food_name, fat), y = fat)) +
  geom_col(fill = "#f15854") +
  coord_flip() + # Makes the bar chart horizontal
  labs(title = "Foods with Extremely High Fat Content (>95th Percentile)",
       x = "Food Name",
       y = "Fat (g)") +
  theme_minimal()

#---------------------------------------------------------------------------------


# ================================================================================
# 12. Compare the distribution of carbs across three selected categories using 
#     a violin plot.
# ================================================================================

target_cats <- unique(food_data$category)[1:3]

print(paste("Selected Categories:", paste(target_cats, collapse = ", ")))

# Subset data
subset_data <- food_data[food_data$category %in% target_cats, ]

ggplot(subset_data, aes(x = category, y = carbs, fill = category)) +
  geom_violin(trim = FALSE, alpha = 0.6) + 
  geom_boxplot(width = 0.1, fill = "grey30", color = "black", outlier.shape = NA) + 
  labs(
    title = "Distribution of Carbohydrates for Selected Categories",
    x = "Category",
    y = "Carbohydrates (g)"
  ) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, 12)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#---------------------------------------------------------------------------------


# ================================================================================
# 13. Create a stacked bar chart showing total calories contributed by each category
### PLEASE EXPAND THE SIZE OF THE PLOT AREA TO FULLY SEE THIS PLOT
## THE LEGEND ALONE IS DENSE
# ================================================================================



# Create the stacked bar chart
# Since the bar chart only needs to show total calories, only calories column is used
ggplot(food_data, aes(x = "All Categories", y = calories, fill = category)) + 
  geom_bar(stat = "identity", width = 0.6) +
  labs(
    title = "Total Calories Contributed by Each Food Category (kcal)",
    x = "Categories",
    y = "Total Calories Accumulated from All Categories (kcal)",
    fill = "Food Category"
  ) +
  guides(
    fill = guide_legend(
      ncol = 5,          # spread legend horizontally
      byrow = TRUE,
      keyheight = unit(0.4, "cm"),
      keywidth  = unit(0.4, "cm")
    )
  ) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "bottom",
    legend.text = element_text(size = 7),
    legend.title = element_text(size = 9)
  )

#---------------------------------------------------------------------------------


# ================================================================================
# 14. Plot a density curve for protein content across all foods
# ================================================================================

# Calculate protein statistics
mean_protein <- mean(food_data$protein, na.rm = TRUE)
median_protein <- median(food_data$protein, na.rm = TRUE)
sd_protein <- sd(food_data$protein, na.rm = TRUE)

# Print the protein statistics
cat("Mean protein:", mean_protein, "\n")
cat("Median protein:", median_protein, "\n")
cat("SD protein:", sd_protein, "\n")

# Create a density plot
ggplot(food_data, aes(x = protein)) +
  geom_density(fill = "lightblue", color = "darkblue", alpha = 0.7) +
  geom_vline(xintercept = mean_protein, color = "red", linetype = "dashed", size = 1) +
  geom_vline(xintercept = median_protein, color = "green", linetype = "dashed", size = 1) +
  labs(title = "Density Distribution of Protein Content",
       x = "Protein Content (g)",
       y = "Density")

#---------------------------------------------------------------------------------


# ================================================================================
# 15. Create a bubble chart where bubble size represents iron content, and axes 
#     are calories vs carbs
# ================================================================================

# Check for missing values in iron column
missing_iron <- sum(is.na(food_data$iron))
cat("Missing iron values:", missing_iron, "\n")

# Filter data with valid iron values
data_with_iron <- food_data[!is.na(food_data$iron), ]

# Print summary
cat("Foods with iron data:", nrow(data_with_iron), "\n")

# Create bubble chart
ggplot(data_with_iron, aes(x = carbs, y = calories, size = iron, color = iron)) +
  geom_point(alpha = 0.6) +
  scale_size_continuous(name = "Iron Content (mg)", range = c(1, 20)) +
  scale_color_gradient(name = "Iron Content (mg)", low = "yellow", high = "red") +
  labs(title = "Bubble Chart: Calories vs Carbohydrates",
       x = "Carbohydrates (g)",
       y = "Calories (kcal)")

#---------------------------------------------------------------------------------


# ================================================================================
# Question 16. Nutrient Ratio Analysis
# a. Calculate protein-to-calorie ratio
# ================================================================================

# We use ifelse to handle potential division by zero if any item has 0 calories
food_data <- food_data %>%
  mutate(ratio = ifelse(calories > 0, protein / calories, 0))

#--------------------------------------------------------------------------


# ================================================================================
# Question 16. Nutrient Ratio Analysis
# b. Identify the top 10 foods with the highest ratio
# ================================================================================
top_10_foods <- food_data %>%
  arrange(desc(ratio)) %>%
  slice_head(n = 10)

print("Top 10 Foods by Protein-to-Calorie Ratio:")
print(top_10_foods %>% select(food_name, ratio))

#---------------------------------------------------------------------------------


# ================================================================================
# Question 16. Nutrient Ratio Analysis
# c. Visualize these top foods using a horizontal bar chart
# ================================================================================

ggplot(top_10_foods, aes(x = reorder(food_name, ratio), y = ratio)) +
  geom_col(fill = "#60bd68") +
  coord_flip() +
  labs(title = "Top 10 Foods by Protein-to-Calorie Ratio",
       x = "Food Name",
       y = "Protein / Calorie Ratio") +
  theme_minimal()

#---------------------------------------------------------------------------------


# ================================================================================
# QUESTION 17: Macronutrient Contribution
# a. Compute percentage contribution of protein, carbs, and fat.
# b. Stacked bar chart by category.
# ================================================================================

# 1. Calculate sum of nutrients by category using aggregate (Base R style)
agg_protein <- aggregate(protein ~ category, data = food_data, FUN = sum, na.rm = TRUE)
agg_carbs <- aggregate(carbs ~ category, data = food_data, FUN = sum, na.rm = TRUE)
agg_fat <- aggregate(fat ~ category, data = food_data, FUN = sum, na.rm = TRUE)

# 2. Merge these dataframes together
macro_merge <- merge(agg_protein, agg_carbs, by = "category")
macro_merge <- merge(macro_merge, agg_fat, by = "category")

# Rename columns for clarity
colnames(macro_merge) <- c("Category", "Total_Protein_g", "Total_Carbs_g", "Total_Fat_g")

# 3. Calculate Caloric Contribution (4-4-9 Rule)
macro_merge$Cal_Protein <- macro_merge$Total_Protein_g * 4
macro_merge$Cal_Carbs <- macro_merge$Total_Carbs_g * 4
macro_merge$Cal_Fat <- macro_merge$Total_Fat_g * 9

# Calculate Total Calories calculated from macros
macro_merge$Total_Cal <- macro_merge$Cal_Protein + macro_merge$Cal_Carbs + macro_merge$Cal_Fat

# 4. Calculate Percentages
macro_merge$Pct_Protein <- (macro_merge$Cal_Protein / macro_merge$Total_Cal) * 100
macro_merge$Pct_Carbs <- (macro_merge$Cal_Carbs / macro_merge$Total_Cal) * 100
macro_merge$Pct_Fat <- (macro_merge$Cal_Fat / macro_merge$Total_Cal) * 100

# Print the table results for the report
print(macro_merge[, c("Category", "Pct_Protein", "Pct_Carbs", "Pct_Fat")])

# 5. Prepare data for plotting using reshape2::melt (Matches Task 9 style)
# We only keep the Percentage columns
plot_data <- macro_merge[, c("Category", "Pct_Protein", "Pct_Carbs", "Pct_Fat")]

# Put into long format
macro_long <- plot_data %>%
  pivot_longer(
    cols = -Category,
    names_to = "Macronutrient",
    values_to = "Percentage"
  )

# Rename variables for better legend labels
macro_long$Macronutrient <- recode(
  macro_long$Macronutrient,
  Pct_Protein = "Protein",
  Pct_Carbs   = "Carbohydrates",
  Pct_Fat     = "Fat"
)

# 6. Create Stacked Bar Chart
ggplot(macro_long, aes(x = Category, y = Percentage, fill = Macronutrient)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = c("Protein" = "#36a2eb", "Carbohydrates" = "#ffcd56", "Fat" = "#ff6384")) +
  labs(
    title = "Macronutrient Composition by Category (Percentage of Calories)",
    x = "Food Category",
    y = "Percentage (%)",
    fill = "Macronutrient"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 70, hjust = 1))

#---------------------------------------------------------------------------------

#--------------------------------End of Script------------------------------------