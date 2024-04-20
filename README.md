# Loan Prediction Project


## Overview

This repository contains a machine learning project aimed at predicting loan approvals using the BigQuery platform. The project utilizes a dataset sourced from [Kaggle Loan Prediction Problem Dataset](https://www.kaggle.com/datasets/altruistdelhite04/loan-prediction-problem-dataset), which contains various features related to loan applications.

## Motivation

The goal of this project is to develop a predictive model that can assist financial institutions in assessing the risk associated with loan applicants. By accurately predicting loan outcomes, lenders can make informed decisions, thereby reducing the risk of defaults and improving overall portfolio performance.

## Dataset

The dataset used in this project is sourced from Kaggle X and contains a comprehensive set of features related to loan applications. It includes information such as applicant demographics, credit history, loan details, and more.

### Features

- Loan_ID
- Gender
- Married
- Dependents
- Education
- Self_Employed
- ApplicantIncome
- CoapplicantIncome
- LoanAmount
- Loan_Amount_Term
- Credit_History
- Property_Area

### Target Variable

- Loan_Status

## Methodology

The project follows a standard machine learning pipeline, which includes the following steps:

1. Data Preprocessing: Cleaning the dataset, handling missing values, encoding categorical variables, and feature scaling.
2. Model Selection: Trying out various machine learning algorithms and selecting the best-performing model based on evaluation metrics.
3. Model Evaluation: Assessing the model's performance using appropriate evaluation metrics and fine-tuning as necessary.

## Results

The final predictive model, RANDOM_FOREST_CLASSIFIER, achieves an roc_auc of 0.9303346653346653 on the test set, demonstrating its effectiveness in predicting loan outcomes. Additionally, key insights gained from the analysis are summarized in the notebooks.

## Contributors

- [Madalena Makiesse](https://github.com/madalenamakiesse)

## License

This project is licensed under the MIT License - please see the license file for details.
