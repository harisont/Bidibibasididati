% Notes from _Introduction to data mining_ (Tan, Steinbach, Kumar)
% Arianna Masciolini

# Introduction

## KDD

We refer to the conversion of raw data into useful information/patterns with the acronym __KDD__ (Knowledge Discovery in Databases).
This process consists of three main steps:
1. __Input data preprocessing__: raw data is converted into a format appropriate for analysis (common preprocessing tasks examples: _feature selection_, _dimensionality reduction_, _normalization_ and _data subsetting_); 
2. Actual __data mining__ (the main data mining tasks will be discussed later on);
3. __Data postprocessing__, e.g. _filtering_, _visualization_ and _pattern interpretation_.

### Data mining tasks
Data mining tasks are divided into two general cathegories:
- Predictive tasks, such as __predictive modeling__, that is building a model for a target variable as a function of explanatory variables. Predictive modeling is called _classification_ when it deals with discrete targets, _regression_ when the targets are continous;
- Descriptive tasks, such as:
  - __association analysis__, which consists in discovering strongly associated features in the data,
  - __cluster analysis__, that is seeking groups of closely related observations,
  - __anomaly detection__.

# Data

