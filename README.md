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


## 4. Construcción del modelo 

* Primero, se dividen los datos en conjuntos de pruebas y entrenamientos con un tamaño de entrenamiento del 80%.
* Para modelar el arbol de decisión se debe tener en cuenta la variable de factor expansión dado que se trabaja con una encuesta.
* Como variable dependiente se tiene el ingreso total (incluidos subsidios del estado), sexo como dummy, números de personas que viven en el hogar, edad y escolaridad.

Se modelaron 2 esquemas de probabilidad clasificatorios utlizando el método ANOVA:
*	**Arbol de decisión para 2017** 
*	**Arbol de decisión para 2009 ajustado el ingreso al IPC** 

## 5. Performance del modelo

El cp de cada modelo es fundamental para su explicación

* Se extrae que de las 4 variables independientes, el árbol podó seleccionando las variables que se ajustan de mejor forma al modelo, eligiendo a las variables edad, número de personas en el hogar y escolaridad para el 2009; y número de personas en el hogar, escolaridad y sexo para el 2017.

* Se destaca que en esta comparación de la década (Casen 2009 y 2017) se obtienen en común las variables número de personas en el hogar y escolaridad. Para el año 2009 el promedio del ingreso total del jefe de hogar es de $2.900.000 pesos chilenos y para el 2017 es de $2.300.000 pesos chilenos para el decil más rico de la muestra total.

* 

### 2017
![alt text](https://github.com/Esteban19967769/Esteban_Proyecto1/blob/3fc62be072d73968f5f4e115b4895618f6ce1a47/Arbol2017.png)

### 2009
![alt text](https://github.com/Esteban19967769/Esteban_Proyect1/blob/554948ab00ae62f6d73d40f70a11890c9219dd51/Rplot20090.png)


## 6. Conclusiones

* En síntesis, en el decil más rico existen serias desigualdades, pues el 1% más rico gana 26,93 veces más que el 1% más pobre de este decil para el 2009 y 58,6 veces para el 2017, lo que demuestra de forma empírica la desigualdad que existe incluso en el decil más rico de Chile.

* Respecto a los árboles de decisión, queda caracterizado que, el 10% más rico de la población percibe en promedio $2.900.000 pesos chilenos para el 2009 y $2.300.000 pesos chilenos para el 2017 y los árboles modelan la selección de las variables que caracterizan al 10% más rico de la población, en las cuales se cuenta con edad, número de personas en el hogar y escolaridad para el 2009; y número de personas en el hogar, escolaridad y sexo para el 2017, teniendo en común las variables número de personas en el hogar y escolaridad en ambos períodos. También se describió la variable años de escolaridad para ambos períodos, destacando que la moda para ambos perídos se concentra en 17 años de escolaridad (carrera universitaria completa) y que para el 2009 los años de escolaridad llegaban a 20 y en 2017 a 22 años.

* ¿cómo desagregar el 10% más rico de Chile? y ¿de qué forma se puede caracterizar al 10% más rico en Chile? Se responde que es por medio de la metodología de los árboles de decisión, dado que este método de machine learning, permite clasificar a las variables y el resultado de la minimización del algoritmo permite conocer valores de la variable dependiente y la selección de las variables independientes, para este caso la desagregación del 10% más rico queda caracterizada por las variables edad, número de personas en el hogar y escolaridad para el 2009; y número de personas en el hogar, escolaridad y sexo para el 2017. Se cumplió el objetivo general de esta investigación, pues se caracterizó al decil más rico de la población chilena para los años 2009 y 2017.












