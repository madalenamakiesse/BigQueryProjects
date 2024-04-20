-- Create a table for clean train data
CREATE OR REPLACE TABLE `loan.train_clean` AS
WITH
-- To get The Quantiles arrays of numeric columns
  QuartilesCTE AS (
    SELECT
      APPROX_Quantiles(ApplicantIncome, 4) AS q_ApplicantIncome,
      APPROX_Quantiles(CoapplicantIncome, 4) AS q_CoapplicantIncome,
      APPROX_Quantiles(LoanAmount, 4) AS q_LoanAmount,
      APPROX_Quantiles(Loan_Amount_Term, 4) AS q_Loan_Amount_Term,
      APPROX_Quantiles(Credit_History, 4) AS q_Credit_History
    FROM 
      `loan.train_`
  ),
  -- Tod get the mode of each categoric column
  ModeCTE AS (
    SELECT
      ARRAY_AGG(Gender ORDER BY Gender LIMIT 1)[OFFSET(0)] AS modeGender,
      ARRAY_AGG(Married ORDER BY Married LIMIT 1)[OFFSET(0)] AS modeMarried,
      ARRAY_AGG(Dependents ORDER BY Dependents LIMIT 1)[OFFSET(0)] AS modeDependents,
      ARRAY_AGG(Education ORDER BY Education LIMIT 1)[OFFSET(0)] AS modeEducation,
      ARRAY_AGG(Self_Employed ORDER BY Self_Employed LIMIT 1)[OFFSET(0)] AS modeSelf_Employed,
      ARRAY_AGG(Property_Area ORDER BY Property_Area LIMIT 1)[OFFSET(0)] AS modeProperty_Area,
      ARRAY_AGG(Loan_Status ORDER BY Loan_Status LIMIT 1)[OFFSET(0)] AS modeLoan_Status
    FROM 
      `loan.train_`
  ),
  -- To fill all NULL values
  CompletedCTE AS (
    SELECT
    -- Numeric values
      IFNULL(ApplicantIncome, q_ApplicantIncome[ORDINAL(2)]) AS ApplicantIncome,
      IFNULL(CoapplicantIncome, q_CoapplicantIncome[ORDINAL(2)]) AS CoapplicantIncome,
      IFNULL(LoanAmount, q_LoanAmount[ORDINAL(2)]) AS LoanAmount,
      IFNULL(Loan_Amount_Term, q_Loan_Amount_Term[ORDINAL(2)]) AS Loan_Amount_Term,
      IFNULL(Credit_History, q_Credit_History[ORDINAL(2)]) AS Credit_History,
    -- Categoric values
      IFNULL(Gender, modeGender) AS Gender,
      IFNULL(Married, modeMarried) AS Married,
      IFNULL(Dependents, modeDependents) AS Dependents,
      IFNULL(Education, modeEducation) AS Education,
      IFNULL(Self_Employed, modeSelf_Employed) AS Self_Employed,
      IFNULL(Property_Area, modeProperty_Area) AS Property_Area,
      IFNULL(Loan_Status, modeLoan_Status) AS Loan_Status,
    FROM 
      `loan.train_`
    CROSS JOIN
      QuartilesCTE, ModeCTE
  )
  SELECT
    Credit_History,
    -- Turn Integer to Float data type
    CAST(ApplicantIncome AS FLOAT64) AS ApplicantIncome,
    CAST(CoapplicantIncome AS FLOAT64) AS CoapplicantIncome,
    CAST(LoanAmount AS FLOAT64) AS LoanAmount,
    CAST(Loan_Amount_Term AS FLOAT64) AS Loan_Amount_Term,
    -- Turn categoric values into Binary values
    IF(Married, 1, 0) AS Married,
    IF(Self_Employed, 1, 0) AS Self_Employed,
    IF(Education='Graduate', 1, 0) AS Education,
    IF(Gender='Female', 1, 2) AS Gender, 
    -- Categoric values with mote tehan two possible values
    CASE
      WHEN Dependents='1' THEN 1
      WHEN Dependents='2' THEN 2
      WHEN Dependents='3+' THEN 3
      ELSE 0
    END AS Dependents,
    CASE
      WHEN Property_Area='SemiUrban' THEN 1
      WHEN Property_Area='Urban' THEN 2
      ELSE 0
    END AS Property_Area,
    -- Target
    IF(Loan_Status, 1, 0) AS Loan_Status
  FROM
    CompletedCTE
  ORDER BY
    ApplicantIncome, CoapplicantIncome, LoanAmount, Loan_Amount_Term;
