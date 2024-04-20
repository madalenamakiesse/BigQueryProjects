-- Create ML models
-- Without TRANSFORM()
CREATE OR REPLACE MODEL `loan.model` 
OPTIONS(
  model_type='logistic_reg',
  labels=['Loan_Status']
) AS 
SELECT 
  *
FROM
  `loan.train_clean`;

-- With TRANSFORM()
CREATE OR REPLACE MODEL `loan.model1` 
TRANSFORM(
  *
)
OPTIONS(
  model_type='logistic_reg',
  labels=['Loan_Status']
) AS 
SELECT 
  *
FROM
  `loan.train_clean`;
  
