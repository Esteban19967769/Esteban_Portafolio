# Esteban_Desegregación_decil_más_rico
Data Science proyecto 1

## 1. Data Science Desegregación del decil más rico: Planeación y recolección de datos del proyecto
* El ingreso es la variable más importante para estudiar la desigualdad económica 
* Se creará una herramienta que analice la desigualdad económica enfocado en la caracterización del 10% más rico de Chile
* Se describirán variables como el sexo, el número de personas por hogar, escolaridad y edad 
* Se utilizó la Casen 2009 y 2017 para el análisis de datos de las variables. La muestra se acota a los encuestados de la Casen, que corresponden al 10% más rico de la población, respecto al ingreso con subsidios del Estado del jefe de hogar entre 18 y 65 años. 
* Se utilizará estadística descriptiva y a través de metodología de árboles de decisión se desagregará el decil más rico de la población, entregando datos relevantes del 10% más rico de Chile con estas características para finalmente caracterizar con las variables correspondientes.

## 2. Limpieza de datos
Aplicación de lenguaje CRUD: crear, leer, actualizar y borrar:

#### Para 2017 y 2009:
*	Filtrar por solo las columnas de interés con las variables: "Zona","Factor_expansión","Paretesco_jefehogar","Sexo","Edad","Ingreso_autónomo", "Ingreso_Total","Ingreso_aut_corr", "Ingreso_tot_corr", "Escolaridad","Deciles", "Núm_per_hogar"
*	Eliminar NA 
*	Filtrar por decil más rico 10% y personas entre 18 y 65 años 
*	Made columns for if different skills were listed in the job description: 
    * R  
    * Stata
    * CSV  

#### Para solo 2009:
* Ajustar el ingreso total del IPC 2009 a 2017 con un reajuste del 27,7%
* Creación nueva columna de IPC reajustado


## 3. EDA. Análisis exploratorio de datos
 A continuación se muestran algunos aspectos destacados de las tablas dinámicas



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


![alt text](https://github.com/Esteban19967769/Esteban_Proyecto1/blob/3fc62be072d73968f5f4e115b4895618f6ce1a47/Arbol2017.png)


















