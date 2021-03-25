# Esteban_Desegregación_decil_más_rico
Data Science proyecto 1

## 1. Data Science Desegregación del decil más rico: Planeación y recolección de datos del proyecto
* El ingreso es la variable más importante para estudiar la desigualdad económica.
* Se creará una herramienta que analice la desigualdad económica enfocado en la caracterización del 10% más rico de Chile.
* Se describirán variables como el ingreso con subsidios del estado, sexo, el número de personas por hogar, escolaridad y edad. 
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
 A continuación se muestran algunos aspectos destacados de las tablas dinámicas, su información descriptiva y la correlación exitente entre las variables numéricas:
 
### 2017
![alt text](https://github.com/Esteban19967769/Esteban_Proyect1/blob/c6a85093d32063c32d957f1e5712566456c1a7c0/Rplot2017.png)
![alt text](https://github.com/Esteban19967769/Esteban_Proyect1/blob/43210f441c194ce6c7d74ff562806b2c0d910ee8/Summary2017.png)

### 2009

![alt text](https://github.com/Esteban19967769/Esteban_Proyect1/blob/d39673e4c3a45534adf42c48d80313fa1c476285/rplot2009.png)
![alt text](https://github.com/Esteban19967769/Esteban_Proyect1/blob/e61ccf2f5626a7fae29deed15c93191deb45032b/summary2009.png)


## 4. Model Building 

##### Primero, se dividen los datos en conjuntos de pruebas y entrenamientos con un tamaño de entrenamiento del 80%.
##### Para modelar el arbol de decisión se debe tener en cuenta la variable de factor expansión dado que se trabaja con una encuesta.
##### Como variable dependiente se tiene el ingreso total (incluidos subsidios del estado), sexo como dummy, números de personas que viven en el hogar, edad y escolaridad.

Se modelaron 2 esquemas de probabilidad clasificatorios utlizando el método ANOVA:
*	**Arbol de decisión para 2017** 
*	**Arbol de decisión para 2009 ajustado el ingreso al IPC** 

## 5. Model performance

El cp de cada modelo es fundamental para su explicación

### 2017
![alt text](https://github.com/Esteban19967769/Esteban_Proyecto1/blob/3fc62be072d73968f5f4e115b4895618f6ce1a47/Arbol2017.png)

### 2009
![alt text](https://github.com/Esteban19967769/Esteban_Proyect1/blob/554948ab00ae62f6d73d40f70a11890c9219dd51/Rplot20090.png)

















