-- Evaluating the models
SELECT
  roc_auc,
  CASE
    WHEN roc_auc > .9 THEN 'Good'
    WHEN roc_auc > .8 THEN 'Fair'    
    WHEN roc_auc > .7 THEN 'Decent'    
    WHEN roc_auc > .6 THEN 'Not Good'
    ELSE 'Poor'
  END AS Model_Quality
FROM
  ML.EVALUATE(MODEL loan.model, (
    SELECT 
      *
    FROM 
      `loan.train_clean`
  ));

SELECT
  roc_auc,
  CASE
    WHEN roc_auc > .9 THEN 'Good'
    WHEN roc_auc > .8 THEN 'Fair'    
    WHEN roc_auc > .7 THEN 'Decent'    
    WHEN roc_auc > .6 THEN 'Not Good'
    ELSE 'Poor'
  END AS Model_Quality
FROM
  ML.EVALUATE(MODEL loan.model1, (
    SELECT 
      *
    FROM 
      `loan.train_clean`
  ));
  -- Evaluating the models
SELECT
  roc_auc,
  CASE
    WHEN roc_auc > .9 THEN 'Good'
    WHEN roc_auc > .8 THEN 'Fair'    
    WHEN roc_auc > .7 THEN 'Decent'    
    WHEN roc_auc > .6 THEN 'Not Good'
    ELSE 'Poor'
  END AS Model_Quality
FROM
  ML.EVALUATE(MODEL loan.model3, (
    SELECT 
      *
    FROM 
      `loan.train_clean`
  ));
