#Para limpiar
rm(list=ls())

#Llamamos la base
casen <- readRDS("../segovia/2017.rds")

dimnames(casen)
#Para saber dónde están las variables

##########################################################
#Agrego al jefe de hogar
casen_arbol <- casen[ , c(8,9,23,24,25,656,658, 757,758,774,768, 772,777,782)]
#Me quedo con las variables: jefe de hogar, sexo, edad, escolaridad, ingreso autónomo, ingreso total  y dau

########################################################
names(casen_arbol) <-c("Zona","Factor_expansión","Paretesco_jefehogar","Sexo","Edad","Ingreso_autónomo",
                       "Ingreso_Total","Ingreso_aut_corr", "Ingreso_tot_corr", "Escolaridad","Deciles", "Núm_per_hogar",
                       "Condición_actividad","Asigna_interno")
#Sexo a variable cualitativa
casen_arbol$Sexo = factor(casen_arbol$Sexo, levels = c(1,2), labels = c("Hombre", "Mujer"))

#Reviso NA y los elimino
summary(casen_arbol)
casen_arbol1 <- na.omit(casen_arbol)
summary(casen_arbol1)

#Boto bases que me estorban


rm(casen)
rm(casen_arbol)


#"Zona","Sexo","Edad", "Escolaridad", "Núm_per_hogar",
#"Condición_actividad","Asigna_interno"



###############################################################

#Solo filtrar por decil 10
CASEN_ARBOLdecilmásrico <- casen_arbol1[casen_arbol1$Deciles==10,]
summary(CASEN_ARBOLdecilmásrico)

#Filtrar solo por jefe de hogar parentesco
CASEN_ARBOLdecilmásricojefe <- CASEN_ARBOLdecilmásrico[CASEN_ARBOLdecilmásrico$Paretesco_jefehogar==1,] 
summary(CASEN_ARBOLdecilmásricojefe)

####################################################################

#Dejar entre 18 y 65 años, debo instalar paquete tidyverse y usar filter
install.packages("tidyverse")
library(tidyverse)
casen_decilyedad <- CASEN_ARBOLdecilmásricojefe %>%  filter(Edad>=18 & Edad<=65) 
  summary(casen_decilyedad)

rm(casen_arbol1)
rm(CASEN_ARBOLdecilmásrico)
rm(CASEN_ARBOLdecilmásricojefe)

#################################################################

#ANÁLISIS EXPLORATORIO DE DATOS**********************
# analisis descriptivo de tablas de frecuencias, histogramas, correlación , etc

library(dplyr)
library(ggplot2) 
library(readxl)
library(gmodels)
library(Hmisc)
library(ggthemes)
library(PerformanceAnalytics)

# eliminacion de valores atípicos
casen_decilyedad0 <- casen_decilyedad %>%  filter(Ingreso_autónomo>=750000) 

summary(casen_decilyedad0)

correlacion_base1 <- casen_decilyedad0[,-1]
correlacion_base2 <- correlacion_base1[,-1]
correlacion_base3 <- correlacion_base2[,-1]
correlacion_base4 <- correlacion_base3[,-1]
correlacion_base5 <- correlacion_base4[,-4]
correlacion_base6 <- correlacion_base5[,-4]
correlacion_base7 <- correlacion_base6[,-5]
correlacion_base8 <- correlacion_base7[,-6]
correlacion_base9 <- correlacion_base8[,-6]
correlacion_base10 <- correlacion_base9[,-2]


#borrar
rm(correlacion_base1)
rm(correlacion_base2)
rm(correlacion_base3)
rm(correlacion_base4)
rm(correlacion_base5)
rm(correlacion_base6)
rm(correlacion_base7)
rm(correlacion_base8)


#chart de correlacion, se activa con dataanalytics paquete
chart.Correlation(correlacion_base9, method = "pearson")

summary(correlacion_base9)


#modelo_multiple <- lm(formula = Ingreso_tot_corr ~ Sexo+Edad+Escolaridad+Núm_per_hogar, data = split_arbol)

#summary(modelo_multiple)

#Para crear nueva variables se usa mutate, FAVOR SI NO SIRVE CARGAR TIDYVERS
#Realizó transformación logarítmica

#casen_decilyedad <- casen_decilyedad%>%mutate(ing_auto_log = Ingreso_autónomo, ing_total_log = Ingreso_Total)

#ggplot(data = casen_decilyedad, aes(x = Ingreso_autónomo)) +
  #geom_histogram(color = "white", fill = "blue") +
  #labs(title = "Distribución ingreso autónomo") +
  #theme(plot.title = element_text(hjust = 0.5))

#ggplot(data = casen_decilyedad, aes(x = Ingreso_Total)) +
  #geom_histogram(color = "white", fill = "red") +
  #labs(title = "Distribución ingreso total") +
  #theme(plot.title = element_text(hjust = 0.5))

####transformo a escala logarítmica al ser estas distribuciones No normales

#casen_decilyedad$ing_auto_log <- log(casen_decilyedad$ing_auto_log)
#casen_decilyedad$ing_total_log <- log(casen_decilyedad$ing_total_log)


#ggplot(data = casen_decilyedad, aes(x = ing_auto_log)) +
  #geom_histogram(color = "white", fill = "black") +
  #labs(title = "Distribución log(autónomo)") +
  #theme(plot.title = element_text(hjust = 0.5))

#ggplot(data = casen_decilyedad, aes(x = ing_total_log)) +
  #geom_histogram(color = "white", fill = "black") +
  #labs(title = "Distribución log(total)") +
  #theme(plot.title = element_text(hjust = 0.5))
############################################################

#Los cargo, SINO SIRVE EL CÓDIGO SE DEBEN INSTALAR PREVIAMENTE CON INSTALL.PACKAGEsomg

library(rattle)
library(rpart.plot) 
library(rpart)                #Implementación de cart
library(dplyr)
install.packages("caret")
install.packages("rsample")
library(rsample)
library(caret)                #Para dividir dataset
library(lattice)
library(ggplot2)
install.packages("survey")
library(survey)


###############################################################3

#Creo la semilla
set.seed(1000)

#Usamos la función sample_frac() de dplyr para obtener un subconjunto de nuestros datos, que consiste en 70% del total de ellos. 
#Usamos también set.seed() para que este ejemplo sea reproducible.
#split_arbol <- initial_split(casen_decilyedad, prop = .8)
#datos_trainEscenario2 <- training(split_arbol)

#Con setdiff() de dplyr, obtenemos el subconjunto de datos complementario al de entrenamiento 
#para nuestro set de prueba, esto es, el 20% restante.
#datos_testEscenario2  <- testing(split_arbol)

#Con setdiff() de dplyr, obtenemos el subconjunto de datos complementario al de entrenamiento 
#para nuestro set de prueba, esto es, el 20% restante.


#########################################

split_arbol <- sample_frac(casen_decilyedad0, .8)

#Con setdiff() de dplyr, obtenemos el subconjunto de datos complementario al de entrenamiento 
#para nuestro set de prueba, esto es, el 20% restante.
arbol_prueba <- setdiff(casen_decilyedad0, split_arbol)

################################################################3

#Ahora revisamos árbol con ingreso sin subsidios del Estado
arbol_yaut_anova <- rpart(formula = Ingreso_autónomo ~ Sexo+Edad+Escolaridad+Núm_per_hogar+
                          Condición_actividad+Zona+Asigna_interno,
               data = split_arbol, weights = Factor_expansión,
               method = "anova", 
               #minsplit #Número de observaciones mínimas en nodo
               #minbucket #Número mínimo de observaciones en nodo terminal, es la 1/3 de minsplit
               #maxdepth #número máximo de observaciones que tendrá el árbol
               
               #A menor maxdepth con muchas frecuencias, menos nodos
               #Y a mayor depth con muchas frecuencias, saldrán miles de nodos
               
               #cp = complejidad de un árbol, tamaño del árbol para separar variables objetivos, un cp (-)
               #nos asegura un árbol completamente crecido
               control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

######################################################################

modelo_multiple <- lm(formula = Ingreso_autónomo ~ Sexo+Escolaridad+Núm_per_hogar
                      , data = split_arbol)


summary(modelo_multiple)
#Edad no es relevante porque se trabaja con la población laboral activa entre 18-65 años

##################################################################

arbol_yaut_anova
#Rel error=numero de elementos mal etiquetados en iteración en relación a los elementos mal etiquetados en la raíz
#como regla general es mejor podar un árbol usando el cp del árbol más pequeño que está dentro de una sd del arbol con xerror más pequeño


rpart.plot(arbol_yaut_anova)

#gráfica
#par(mfrow=c(2,2)); plotcp(arbol_yaut_class);  plotcp(arbol_yaut_anova); rpart.plot(arbol_yaut_class);rpart.plot(arbol_yaut_anova)
par(mfrow=c(1,2)); plotcp(arbol_yaut_anova);rpart.plot(arbol_yaut_anova)

#Ahora veremos el error del modelo
printcp(arbol_yaut_anova)
#Segun los resultados de mi arbol, el mejor modelo a cp usar es 0.0013126



##################################################
arbol_ytot_anova <- rpart(formula = Ingreso_Total ~Sexo+Edad+Escolaridad+Núm_per_hogar,
                          data = split_arbol, weights = Factor_expansión,
                          method = "anova", 
                          control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))







#gráfica QUE APARECE EN LA TESIS


par(mfrow=c(1,2)); plotcp(arbol_ytot_anova);rpart.plot(arbol_ytot_anova)















######################################################3

#Ahora veremos el error del modelo
printcp(arbol_ytot_anova)
#Segun los resultados de mi árbol, el mejor modelo a cp usar es 0.0013126


###################################################################
arbol_autcorr_anova <- rpart(formula = Ingreso_aut_corr ~ Sexo+Edad+Escolaridad+Núm_per_hogar+
                            Condición_actividad+Zona+Asigna_interno,
                          data = split_arbol, weights = Factor_expansión,
                          method = "anova", 
                          #minsplit #Número de observaciones mínimas en nodo
                          #minbucket #Número mínimo de observaciones en nodo terminal, es la 1/3 de minsplit
                          #maxdepth #número máximo de observaciones que tendrá el árbol
                          
                          #A menor maxdepth con muchas frecuencias, menos nodos
                          #Y a mayor depth con muchas frecuencias, saldrán miles de nodos
                          
                          #cp = complejidad de un árbol, tamaño del árbol para separar variables objetivos, un cp (-)
                          #nos asegura un árbol completamente crecido
                          control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

par(mfrow=c(1,2)); plotcp(arbol_autcorr_anova);rpart.plot(arbol_autcorr_anova)

######################################################################

###################################################################
arbol_totcorr_anova <- rpart(formula = Ingreso_tot_corr ~ Sexo+Edad+Escolaridad+Núm_per_hogar+
                               Condición_actividad+Zona+Asigna_interno,
                             data = split_arbol, weights = Factor_expansión,
                             method = "anova", 
                             #minsplit #Número de observaciones mínimas en nodo
                             #minbucket #Número mínimo de observaciones en nodo terminal, es la 1/3 de minsplit
                             #maxdepth #número máximo de observaciones que tendrá el árbol
                             
                             #A menor maxdepth con muchas frecuencias, menos nodos
                             #Y a mayor depth con muchas frecuencias, saldrán miles de nodos
                             
                             #cp = complejidad de un árbol, tamaño del árbol para separar variables objetivos, un cp (-)
                             #nos asegura un árbol completamente crecido
                             control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

par(mfrow=c(1,2)); plotcp(arbol_totcorr_anova);rpart.plot(arbol_autcorr_anova)

######################################################################

#PREGUNTAS:
#Si minsplit supera la mitad del número de observaciones se genera solo el tallo del árbol
#Si minbucket supera la mitad de observaciones no se generan divisiones
#Todos los comandos de rpart.control nos permite un control del árbol, sino sería 100% preciso


##CON LOGARITMO no va

arbol_logaut_anova <- rpart(formula = ing_auto_log ~ Sexo+Edad+Escolaridad+Núm_per_hogar+
                               Condición_actividad+Zona+Asigna_interno,
                             data = split_arbol, weights = Factor_expansión,
                             method = "anova", 
                             #minsplit #Número de observaciones mínimas en nodo
                             #minbucket #Número mínimo de observaciones en nodo terminal, es la 1/3 de minsplit
                             #maxdepth #número máximo de observaciones que tendrá el árbol
                             
                             #A menor maxdepth con muchas frecuencias, menos nodos
                             #Y a mayor depth con muchas frecuencias, saldrán miles de nodos
                             
                             #cp = complejidad de un árbol, tamaño del árbol para separar variables objetivos, un cp (-)
                             #nos asegura un árbol completamente crecido
                             control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

par(mfrow=c(1,2)); plotcp(arbol_logaut_anova);rpart.plot(arbol_logaut_anova)

######################################################################

quantile(casen_decilyedad$Ingreso_aut_corr, prob=seq(0, 1, length = 11))

quantile(casen_decilyedad$Ingreso_tot_corr, prob=seq(0, 1, length = 11))
