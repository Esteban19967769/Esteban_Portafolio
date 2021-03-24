# Esteban_Desegregación_decil_más_rico
Data Science proyecto 1

## 1. Data Science Desegregación del decil más rico: Planeación y recolección de datos del proyecto
* El ingreso es la variable más importante para estudiar la desigualdad económica 
* Se creará una herramienta que analice la desigualdad económica enfocado en la caracterización del 10% más rico de Chile
* Se describirán variables como el sexo, el número de personas por hogar, escolaridad y edad 
* Se utilizó la Casen 2009 y 2017 para el análisis de datos de las variables. La muestra se acota a los encuestados de la Casen, que corresponden al 10% más rico de la población, respecto al ingreso con subsidios del Estado del jefe de hogar entre 18 y 65 años. 
* Se utilizará estadística descriptiva y a través de metodología de árboles de decisión se desagregará el decil más rico de la población, entregando datos relevantes del 10% más rico de Chile con estas características para finalmente caracterizar con las variables correspondientes.

## 2. Data Cleaning
After scraping the data, I needed to clean it up so that it was usable for our model. I made the following changes and created the following variables:

*	Parsed numeric data out of salary 
*	Made columns for employer provided salary and hourly wages 
*	Removed rows without salary 
*	Parsed rating out of company text 
*	Made a new column for company state 
*	Added a column for if the job was at the company’s headquarters 
*	Transformed founded date into age of company 
*	Made columns for if different skills were listed in the job description: 
    * R  
    * Excel  
*	Column for simplified job title and Seniority 
*	Column for description length 

## 3. EDA. Análisis exploratorio de datos
I looked at the distributions of the data and the value counts for the various categorical variables. Below are a few highlights from the pivot tables. 

![alt text](https://github.com/PlayingNumbers/ds_salary_proj/blob/master/salary_by_job_title.PNG "Salary by Position")
![alt text](https://github.com/PlayingNumbers/ds_salary_proj/blob/master/positions_by_state.png "Job Opportunities by State")
![alt text](https://github.com/PlayingNumbers/ds_salary_proj/blob/master/correlation_visual.png "Correlations")


## 4. Model Building 

First, I transformed the categorical variables into dummy variables. I also split the data into train and tests sets with a test size of 20%.   

I tried three different models and evaluated them using Mean Absolute Error. I chose MAE because it is relatively easy to interpret and outliers aren’t particularly bad in for this type of model.   

I tried three different models:
*	**Multiple Linear Regression** – Baseline for the model
*	**Lasso Regression** – Because of the sparse data from the many categorical variables, I thought a normalized regression like lasso would be effective.
*	**Random Forest** – Again, with the sparsity associated with the data, I thought that this would be a good fit. 

## 5. Model performance
The Random Forest model far outperformed the other approaches on the test and validation sets. 
*	**Random Forest** : MAE = 11.22
*	**Linear Regression**: MAE = 18.86
*	**Ridge Regression**: MAE = 19.67




















