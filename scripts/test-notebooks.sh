#!/bin/bash

set -e

# Remove any FGs, FVs, Models, Deployments
jupyter nbconvert --to notebook --execute scripts/cleanup-tutorials.ipynb

# fraud batch
jupyter nbconvert --to notebook --execute fraud_batch/1_fraud_batch_feature_pipeline.ipynb 
jupyter nbconvert --to notebook --execute fraud_batch/2_fraud_batch_training_pipeline.ipynb
jupyter nbconvert --to notebook --execute fraud_batch/3_fraud_batch_inference.ipynb

# fraud online
jupyter nbconvert --to notebook --execute fraud_online/1_fraud_online_feature_pipeline.ipynb 
jupyter nbconvert --to notebook --execute fraud_online/2_fraud_online_training_pipeline.ipynb
jupyter nbconvert --to notebook --execute fraud_online/3_fraud_online_inference_pipeline.ipynb

# Remove any FGs, FVs, Models, Deployments
jupyter nbconvert --to notebook --execute scripts/cleanup-tutorials.ipynb

# churn
jupyter nbconvert --to notebook --execute churn/1_churn_feature_pipeline.ipynb 
jupyter nbconvert --to notebook --execute churn/2_churn_training_pipeline.ipynb
jupyter nbconvert --to notebook --execute churn/3_churn_batch_inference.ipynb

# Great Expectations
jupyter nbconvert --to notebook --execute integrations/great_expectations/Great_Expectations_Hopsworks_Concepts.ipynb
jupyter nbconvert --to notebook --execute integrations/great_expectations/fraud_batch_data_validation.ipynb

# Remove any FGs, FVs, Models, Deployments
jupyter nbconvert --to notebook --execute scripts/cleanup-tutorials.ipynb

# Advanced Tutorials
cd advanced_tutorials

# Citibike
jupyter nbconvert --to notebook --execute citibike/1_citibike_feature_backfill.ipynb 
jupyter nbconvert --to notebook --execute citibike/2_citibike_feature_pipeline.ipynb 
jupyter nbconvert --to notebook --execute citibike/3_citibike_training_pipeline.ipynb 
jupyter nbconvert --to notebook --execute citibike/4_citibike_batch_inference.ipynb 

# Credit Scores
jupyter nbconvert --to notebook --execute credit_scores/1_credit_scores_feature_backfill.ipynb 
jupyter nbconvert --to notebook --execute credit_scores/2_credit_scores_feature_pipeline.ipynb 
jupyter nbconvert --to notebook --execute credit_scores/3_credit_scores_training_pipeline.ipynb 
jupyter nbconvert --to notebook --execute credit_scores/4_credit_scores_batch_inference.ipynb 

# Remove any FGs, FVs, Models, Deployments
jupyter nbconvert --to notebook --execute ../scripts/cleanup-tutorials.ipynb

# Electricity
jupyter nbconvert --to notebook --execute electricity/1_electricity_feature_backfill.ipynb 
jupyter nbconvert --to notebook --execute electricity/2_electricity_feature_pipeline.ipynb 
jupyter nbconvert --to notebook --execute electricity/3_electricity_training_pipeline.ipynb 
jupyter nbconvert --to notebook --execute electricity/4_electricity_batch_inference.ipynb 

# Nyc Taxi Fares
jupyter nbconvert --to notebook --execute nyc_taxi_fares/1_nyc_taxi_fares_feature_backfill.ipynb
jupyter nbconvert --to notebook --execute nyc_taxi_fares/2_nyc_taxi_fares_feature_pipeline.ipynb
jupyter nbconvert --to notebook --execute nyc_taxi_fares/3_nyc_taxi_fares_training_pipeline.ipynb
jupyter nbconvert --to notebook --execute nyc_taxi_fares/4_nyc_taxi_fares_batch_inference.ipynb

# Remove any FGs, FVs, Models, Deployments
jupyter nbconvert --to notebook --execute ../scripts/cleanup-tutorials.ipynb