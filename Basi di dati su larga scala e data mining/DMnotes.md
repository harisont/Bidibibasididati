% Data mining notes
% Arianna Masciolini
Sources:

- _Introduction to data mining_ (Tan, Steinbach, Kumar)

# Introduction

## KDD

We refer to the conversion of raw data into useful information/patterns with the acronym __KDD__ (Knowledge Discovery in Databases).
This process consists of three main steps:

1. __Input data preprocessing__: raw data is converted into a format appropriate for analysis (common preprocessing tasks examples: _feature selection_, _dimensionality reduction_, _normalization_ and _data subsetting_); 
2. Actual __data mining__ (the main data mining tasks will be discussed later on);
3. __Data postprocessing__, e.g. _filtering_, _visualization_ and _pattern interpretation_.


### Data mining tasks
Data mining tasks are divided into two general categories:
- Predictive tasks, such as __predictive modeling__, that is building a model for a target variable as a function of explanatory variables. Predictive modeling is called _classification_ when it deals with discrete targets, _regression_ when the targets are continuous;

- Descriptive tasks, such as:
  
  - __association analysis__, which consists in discovering strongly associated features in the data,
  - __cluster analysis__, that is seeking groups of closely related observations,
  - __anomaly detection__.


# Data
The type and the quality of the data are important for successful data mining. Also, raw data often have to be preprocessed so that thay better fit a specific data mining technique. 
A __data set__ is a collection of _data objects_ or _records_ described by a number of _attributes_. An __attribute__ is a property of a data object that may vary from one sample to another and from one time to another, associated to numerical or symbolic values by a a _measurement scale_.

## Types of data
 As the values used to represent an attribute may have properties that are not the properties of the attribute itself (and vice versa), many different types of measurement scale (aka types of attributes) exist. Of course, the digital representation of an attribute is intrinsically numerical, so a good way to specify the type of an attribute is to identify the properties of numbers that correspond to to underlying properties of the attribute. Some of those are:

1. distinctness,
2. order,
3. addition (+ and -),
4. multiplication (* and /).

Given these properties of numbers, we can define four types of attributes, divided in two categories, that can also be described in terms of _permissible transformations_, i.e. transformations that don't change the meaning of the attribute itself: 

| Category | Attribute type | Meaningful properties | Permissible transformations | Examples |
|:---:|:---:|:---:|:---:|:---:|
| categorical/qualitative | __nominal__ | 1 | any one-to one mapping | id numbers |
| categorical/qualitative | __ordinal__ | 1,2 | an order-preserving change of values | grades |
| numeric/quantitative | __interval__ | 1, 2, 3 | _newvalue = a*oldvalue + b_, where _a_ and _b_ are constants | temperatures |
| numeric/quantitative | __ratio__ | 1, 2, 3, 4 | _newvalue = a*oldvalue_ (change of unit) | time, lengths |

We can also describe attributes in terms number of values they can take, so that we divide the into:

- __discrete__ attributes, that have a finite or countably finite set of possible values;
- __continuous__ attributes, whose values are real numbers.


## Data sets
The main characteristics of a data set are the following:

- __Dimensionality__: number of attributes of the data objects;
- __Sparsity__, which leads to significant savings in computation time and storage; 
- __Resolution__: it is important that the level of resolution is not too fine nor coarse, as patterns may vary depending on it.

### Types of data sets
It is convenient to distinguish three groups of data set types: __record data__, __graph-based data__ and __Ordered data__.

#### Record data
Much data mining work assumes that the data set consists in a collection of data objects, each of which has a fixed set of attributes. This kind of data is called _record data_ and is usually stored in flat files or relational databases. In the latter case, anyway, the database just serves as a convenient place to find records, as data mining often doesn't make use of all the additional information the database structure provides. 
As the fact relational databases are often used to store record data suggests, we can imagine the corresponding kind of data sets as _m_ by _n_ matrices (__data matrices__), where there is one row for each object and one column for each attribute, or vice versa. Data matrices are an interesting variation of record data, because with this representation standard matrix operations can be applied to manipulate the data. 
A special type of record data is __transaction data__, where each record or transaction involves a _set_ of items. A good example of a data object in a record data set are the products in a person's "market basket": that's why such collections of sets of items are also called __market basket data__.

#### Graph-based data
There are two kinds of graph based data:

- data sets where the graph captures relationships among different data objects;
- data sets where the data objects themselves are represented as graphs. This is convenient when such objects are structured, i.e. they contain subobjects that have significant relationships.

#### Ordered data
For some types of data, the attributes have relationships that involve temporal or spatial order:

- Sequential or __temporal data__: record data where each record has a timestamp associated with it. A special kind of temporal data is __time series data__, where each record consists of a series of measurements taken over time;
- __Sequence data__: same as temporal data, with positions in an ordered sequence instead of timestamps;
- __Spatial data__, distributed on a two or three dimensional grid.


## Data quality
Data mining usually can't rely on optimal data sets, as data was often collected for other purpose, so it focuses on the detection and correction of data quality problems (__data cleaning__) and on the use of __algorithms that can tolerate poor data quality__-.
Data quality issues that often need to be addressed include both the presence of noise and outliers and missing, inconsistent, duplicate, biased or otherwise unrepresentative data.

## Data preprocessing
This section will cover the most important data preprocessing approaches and the interrelationships among them.

### Aggregation
Aggregating data means combining multiple records (or attributes) into a single data object (or attribute). 
Even though a disadvantage of aggregation is the potential loss of interesting details, there are a few motivations for aggregation:

- aggregation means data reduction: small data sets require less memory and processing time, so that more expensive data mining algorithms can be applied;
- aggregation can act as a change of scale, providing a higher-level view of the data;
- the behavior of groups of objects is often more stable than that of individual the individual ones.

### Sampling
Sampling is a commonly used approach for selecting a subset of the data objects to be analyzed. It's useful both for statisticians, when _obtaining_ the entire data set is too expensive, and data miners, when the existing data set is too large to be entirely _processed_.
The key point is that using a representative sample, i.e. a sample that has approximately the same properties of interest as the original data set, instead of the entire data set will work almost equally well. 
The essential approaches to sampling are the following:

- __simple random sampling__: equal probability of selecting any particular item. It can be done with or without replacement (in the former case, objects are not removed from the population as they're selected for the sample, thus the probability of choosing any object _remains_ constant);
- __stratified sampling__: this comes in handy when the population consists of different types of objects, each with a widely different number of objects, because in this case simple random sampling can fail to adequately represent the less frequent types objects. With the most basic stratified sampling technique, equal numbers of objects are drawn from each group, while in another variation the number of objects drawn from each group is proportional to the size of the group itself.

Determining the proper sample size is sometimes difficult, so _progressive_ (aka _adaptive_) schemes are used in such cases. They start with a small sample and increase its size until a it is large enough.

### Dimensionality reduction
High-dimensional data are extremely difficult to analyze, so that the preprocessing step frequently involves dimensionality reduction. Its main purpose is to avoid the so-called "curse of dimensionality": when dimensionality increases, data become increasingly sparse, occupying way too much space. The most common techniques for dimensionality reduction, based on linear algebra, are:

- __PCA__ (Principal Components Analysis), that finds new attributes, called _principal components_ that:
  - are linear combinations of the original ones,
  - are orthogonal to each other,
  - capture the maximum amount of variation in the data; 
- __SVD__ (Singular Values Decomposition);
- __ISOMAP__.

### Feature subset selection
Another way to reduce dimensionality is to simply remove redundant or irrelevant features. The brute-force approach, i.e. trying all possible subsets of features as input to the chosen data mining algorithm an then take the subset that produces the best results, is impractical in most situations, so that three standard approaches have been developed:

- __embedded__: feature selection occurs naturally as part of the data mining algorithm;
- __filter__: features are selected before the data mining algorithm is run, using an approach that is independent of the data mining task;
- __wrapper__: the target data mining algorithm is used as a black box to select the significant features, without enumerating all possible subsets.

### Feature creation
Feature creation consists in the creation of a new set of attributes that captures the important information in a more efficient way than the original one. Next, three methodologies for feature creation are described:

- __feature extraction__, highly domain-specific;
- __mapping data to a new space__;
- __feature construction__.


### Discretization and binarization
Discretization and binarization are used when the chosen data mining algorithm requires data in the form of categorical attributes.

### Attribute transformation
The term refers to a function that maps the entire set of values of a given attribute to a new set of replacement values. Two important types of such transformations are:
- __simple functions__ (a simple mathematical function is applied to each value individually); 
- __normalization__ (aka __standardization__), where the goal is to make an entire set of values satisfy a particular property.

#### Simple functions

#### Normalization