-- Predict
SELECT
  Credit_History, 
  ApplicantIncome, 
  CoapplicantIncome, 
  LoanAmount, 
  Loan_Amount_Term, 
  Married, 
  Self_Employed, 
  Education, 
  Gender, 
  Dependents, 
  Property_Area, 
  predicted_Loan_Status
FROM
  ML.PREDICT(MODEL `loan.model`, (
    SELECT
      *
    FROM
      `loan.test_clean`
  ));
