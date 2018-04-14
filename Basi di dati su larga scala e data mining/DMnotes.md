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


# I. Data
The type and the quality of the data are important for successful data mining. Also, raw data often have to be preprocessed so that thay better fit a specific data mining technique. 
Data quality issues that often need to be addressed include both the presence of noice and outliers and missing, inconsistent, duplicate, biased or otherwise unrepresentative data.

## Types of data
A __data set__ is a collection of _data objects_ or _records_ described by a number of _attributes_. An __attribute__ is a property of a data object that may vary from one sample to another and from one time to another, associated to numerical or symbolic values by a a _measurement scale_. As the values used to represent an attribute may have properties that are not the properties of the attribute itself (and vice versa), many different types of measurement scale (aka types of attributes) exist. Of course, the digital representation of an attribute is intrinsecally numerical, so a good way to specify the type of an attribute is to identify the properties of numbers that correspond to to underlying properties of the attribute. Some of those are:

1. distinctness,
2. order,
3. addition (+ and -),
4. multiplication (* and /).

Given these properties of numbers, we can define four types of attributes: _nominal_ (meaningful properties: 1), _ordinal_ (m.p.: 2), _interval_ (m.p.: 3) and _ratio_ (m.p.: 3).