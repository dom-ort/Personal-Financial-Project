library(readr)
library(readxl)
library(tidyverse)
install.packages('psych')
library(psych)
library(ggplot2)

cleaned_data <- read_excel("Data/Cleaned_Data.xlsx")

 
# Checking the data and ensuring its the correct 
# format before analysis

head(cleaned_data)
str(cleaned_data)
view(cleaned_data)

# Basic Stats

# Zeroes are skewing the analysis
# Huge outliers heavily skew data (interest, low expenses, etc.)
summary(cleaned_data, na.rm = TRUE)
describe(cleaned_data, na.rm = TRUE)

# Removing zeroes

colnames(cleaned_data)

no_zero_expense <- ifelse(cleaned_data$`Expense Amount`>0,cleaned_data$`Expense Amount`, NA)

mean(no_zero_expense, na.rm = TRUE)
median(no_zero_expense, na.rm = TRUE)
min(no_zero_expense, na.rm = TRUE)
max(no_zero_expense, na.rm = TRUE)

no_zero_income <- ifelse(cleaned_data$`Income Amount`>0,cleaned_data$`Income Amount`, NA)

mean(no_zero_income, na.rm = TRUE)
median(no_zero_income, na.rm = TRUE)
min(no_zero_income, na.rm = TRUE)
max(no_zero_income, na.rm = TRUE)

no_zero_payment <- ifelse(cleaned_data$`Payment Amount`>0,cleaned_data$`Payment Amount`, NA)

mean(no_zero_payment, na.rm = TRUE)
median(no_zero_payment, na.rm = TRUE)
min(no_zero_payment, na.rm = TRUE)
max(no_zero_payment, na.rm = TRUE)

describe(no_zero_expense)
describe(no_zero_income)
describe(no_zero_payment)

summary(no_zero_expense)
summary(no_zero_income)
summary(no_zero_payment)

IQR(no_zero_expense, na.rm = TRUE)
IQR(no_zero_income, na.rm = TRUE)
IQR(no_zero_payment, na.rm = TRUE)
