#Para limpiar
rm(list=ls())

#Llamamos la base
casen <- readRDS("../segovia/2017.rds")

dimnames(casen)
#Para saber d�nde est�n las variables

##########################################################
#Agrego al jefe de hogar
casen_arbol <- casen[ , c(8,9,23,24,25,656,658, 757,758,774,768, 772,777,782)]
#Me quedo con las variables: jefe de hogar, sexo, edad, escolaridad, ingreso aut�nomo, ingreso total  y dau

########################################################
names(casen_arbol) <-c("Zona","Factor_expansi�n","Paretesco_jefehogar","Sexo","Edad","Ingreso_aut�nomo",
                       "Ingreso_Total","Ingreso_aut_corr", "Ingreso_tot_corr", "Escolaridad","Deciles", "N�m_per_hogar",
                       "Condici�n_actividad","Asigna_interno")
#Sexo a variable cualitativa
casen_arbol$Sexo = factor(casen_arbol$Sexo, levels = c(1,2), labels = c("Hombre", "Mujer"))

#Reviso NA y los elimino
summary(casen_arbol)
casen_arbol1 <- na.omit(casen_arbol)
summary(casen_arbol1)

#Boto bases que me estorban


rm(casen)
rm(casen_arbol)


#"Zona","Sexo","Edad", "Escolaridad", "N�m_per_hogar",
#"Condici�n_actividad","Asigna_interno"



###############################################################

#Solo filtrar por decil 10
CASEN_ARBOLdecilm�srico <- casen_arbol1[casen_arbol1$Deciles==10,]
summary(CASEN_ARBOLdecilm�srico)

#Filtrar solo por jefe de hogar parentesco
CASEN_ARBOLdecilm�sricojefe <- CASEN_ARBOLdecilm�srico[CASEN_ARBOLdecilm�srico$Paretesco_jefehogar==1,] 
summary(CASEN_ARBOLdecilm�sricojefe)

####################################################################

#Dejar entre 18 y 65 a�os, debo instalar paquete tidyverse y usar filter
install.packages("tidyverse")
library(tidyverse)
casen_decilyedad <- CASEN_ARBOLdecilm�sricojefe %>%  filter(Edad>=18 & Edad<=65) 
  summary(casen_decilyedad)

rm(casen_arbol1)
rm(CASEN_ARBOLdecilm�srico)
rm(CASEN_ARBOLdecilm�sricojefe)

#################################################################

#AN�LISIS EXPLORATORIO DE DATOS**********************
# analisis descriptivo de tablas de frecuencias, histogramas, correlaci�n , etc

library(dplyr)
library(ggplot2) 
library(readxl)
library(gmodels)
library(Hmisc)
library(ggthemes)
library(PerformanceAnalytics)

# eliminacion de valores at�picos
casen_decilyedad0 <- casen_decilyedad %>%  filter(Ingreso_aut�nomo>=750000) 

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


#modelo_multiple <- lm(formula = Ingreso_tot_corr ~ Sexo+Edad+Escolaridad+N�m_per_hogar, data = split_arbol)

#summary(modelo_multiple)

#Para crear nueva variables se usa mutate, FAVOR SI NO SIRVE CARGAR TIDYVERS
#Realiz� transformaci�n logar�tmica

#casen_decilyedad <- casen_decilyedad%>%mutate(ing_auto_log = Ingreso_aut�nomo, ing_total_log = Ingreso_Total)

#ggplot(data = casen_decilyedad, aes(x = Ingreso_aut�nomo)) +
  #geom_histogram(color = "white", fill = "blue") +
  #labs(title = "Distribuci�n ingreso aut�nomo") +
  #theme(plot.title = element_text(hjust = 0.5))

#ggplot(data = casen_decilyedad, aes(x = Ingreso_Total)) +
  #geom_histogram(color = "white", fill = "red") +
  #labs(title = "Distribuci�n ingreso total") +
  #theme(plot.title = element_text(hjust = 0.5))

####transformo a escala logar�tmica al ser estas distribuciones No normales

#casen_decilyedad$ing_auto_log <- log(casen_decilyedad$ing_auto_log)
#casen_decilyedad$ing_total_log <- log(casen_decilyedad$ing_total_log)


#ggplot(data = casen_decilyedad, aes(x = ing_auto_log)) +
  #geom_histogram(color = "white", fill = "black") +
  #labs(title = "Distribuci�n log(aut�nomo)") +
  #theme(plot.title = element_text(hjust = 0.5))

#ggplot(data = casen_decilyedad, aes(x = ing_total_log)) +
  #geom_histogram(color = "white", fill = "black") +
  #labs(title = "Distribuci�n log(total)") +
  #theme(plot.title = element_text(hjust = 0.5))
############################################################

#Los cargo, SINO SIRVE EL C�DIGO SE DEBEN INSTALAR PREVIAMENTE CON INSTALL.PACKAGEsomg

library(rattle)
library(rpart.plot) 
library(rpart)                #Implementaci�n de cart
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

#Usamos la funci�n sample_frac() de dplyr para obtener un subconjunto de nuestros datos, que consiste en 70% del total de ellos. 
#Usamos tambi�n set.seed() para que este ejemplo sea reproducible.
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

#Ahora revisamos �rbol con ingreso sin subsidios del Estado
arbol_yaut_anova <- rpart(formula = Ingreso_aut�nomo ~ Sexo+Edad+Escolaridad+N�m_per_hogar+
                          Condici�n_actividad+Zona+Asigna_interno,
               data = split_arbol, weights = Factor_expansi�n,
               method = "anova", 
               #minsplit #N�mero de observaciones m�nimas en nodo
               #minbucket #N�mero m�nimo de observaciones en nodo terminal, es la 1/3 de minsplit
               #maxdepth #n�mero m�ximo de observaciones que tendr� el �rbol
               
               #A menor maxdepth con muchas frecuencias, menos nodos
               #Y a mayor depth con muchas frecuencias, saldr�n miles de nodos
               
               #cp = complejidad de un �rbol, tama�o del �rbol para separar variables objetivos, un cp (-)
               #nos asegura un �rbol completamente crecido
               control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

######################################################################

modelo_multiple <- lm(formula = Ingreso_aut�nomo ~ Sexo+Escolaridad+N�m_per_hogar
                      , data = split_arbol)


summary(modelo_multiple)
#Edad no es relevante porque se trabaja con la poblaci�n laboral activa entre 18-65 a�os

##################################################################

arbol_yaut_anova
#Rel error=numero de elementos mal etiquetados en iteraci�n en relaci�n a los elementos mal etiquetados en la ra�z
#como regla general es mejor podar un �rbol usando el cp del �rbol m�s peque�o que est� dentro de una sd del arbol con xerror m�s peque�o


rpart.plot(arbol_yaut_anova)

#gr�fica
#par(mfrow=c(2,2)); plotcp(arbol_yaut_class);  plotcp(arbol_yaut_anova); rpart.plot(arbol_yaut_class);rpart.plot(arbol_yaut_anova)
par(mfrow=c(1,2)); plotcp(arbol_yaut_anova);rpart.plot(arbol_yaut_anova)

#Ahora veremos el error del modelo
printcp(arbol_yaut_anova)
#Segun los resultados de mi arbol, el mejor modelo a cp usar es 0.0013126



##################################################
arbol_ytot_anova <- rpart(formula = Ingreso_Total ~Sexo+Edad+Escolaridad+N�m_per_hogar,
                          data = split_arbol, weights = Factor_expansi�n,
                          method = "anova", 
                          control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))







#gr�fica QUE APARECE EN LA TESIS


par(mfrow=c(1,2)); plotcp(arbol_ytot_anova);rpart.plot(arbol_ytot_anova)















######################################################3

#Ahora veremos el error del modelo
printcp(arbol_ytot_anova)
#Segun los resultados de mi �rbol, el mejor modelo a cp usar es 0.0013126


###################################################################
arbol_autcorr_anova <- rpart(formula = Ingreso_aut_corr ~ Sexo+Edad+Escolaridad+N�m_per_hogar+
                            Condici�n_actividad+Zona+Asigna_interno,
                          data = split_arbol, weights = Factor_expansi�n,
                          method = "anova", 
                          #minsplit #N�mero de observaciones m�nimas en nodo
                          #minbucket #N�mero m�nimo de observaciones en nodo terminal, es la 1/3 de minsplit
                          #maxdepth #n�mero m�ximo de observaciones que tendr� el �rbol
                          
                          #A menor maxdepth con muchas frecuencias, menos nodos
                          #Y a mayor depth con muchas frecuencias, saldr�n miles de nodos
                          
                          #cp = complejidad de un �rbol, tama�o del �rbol para separar variables objetivos, un cp (-)
                          #nos asegura un �rbol completamente crecido
                          control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

par(mfrow=c(1,2)); plotcp(arbol_autcorr_anova);rpart.plot(arbol_autcorr_anova)

######################################################################

###################################################################
arbol_totcorr_anova <- rpart(formula = Ingreso_tot_corr ~ Sexo+Edad+Escolaridad+N�m_per_hogar+
                               Condici�n_actividad+Zona+Asigna_interno,
                             data = split_arbol, weights = Factor_expansi�n,
                             method = "anova", 
                             #minsplit #N�mero de observaciones m�nimas en nodo
                             #minbucket #N�mero m�nimo de observaciones en nodo terminal, es la 1/3 de minsplit
                             #maxdepth #n�mero m�ximo de observaciones que tendr� el �rbol
                             
                             #A menor maxdepth con muchas frecuencias, menos nodos
                             #Y a mayor depth con muchas frecuencias, saldr�n miles de nodos
                             
                             #cp = complejidad de un �rbol, tama�o del �rbol para separar variables objetivos, un cp (-)
                             #nos asegura un �rbol completamente crecido
                             control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

par(mfrow=c(1,2)); plotcp(arbol_totcorr_anova);rpart.plot(arbol_autcorr_anova)

######################################################################

#PREGUNTAS:
#Si minsplit supera la mitad del n�mero de observaciones se genera solo el tallo del �rbol
#Si minbucket supera la mitad de observaciones no se generan divisiones
#Todos los comandos de rpart.control nos permite un control del �rbol, sino ser�a 100% preciso


##CON LOGARITMO no va

arbol_logaut_anova <- rpart(formula = ing_auto_log ~ Sexo+Edad+Escolaridad+N�m_per_hogar+
                               Condici�n_actividad+Zona+Asigna_interno,
                             data = split_arbol, weights = Factor_expansi�n,
                             method = "anova", 
                             #minsplit #N�mero de observaciones m�nimas en nodo
                             #minbucket #N�mero m�nimo de observaciones en nodo terminal, es la 1/3 de minsplit
                             #maxdepth #n�mero m�ximo de observaciones que tendr� el �rbol
                             
                             #A menor maxdepth con muchas frecuencias, menos nodos
                             #Y a mayor depth con muchas frecuencias, saldr�n miles de nodos
                             
                             #cp = complejidad de un �rbol, tama�o del �rbol para separar variables objetivos, un cp (-)
                             #nos asegura un �rbol completamente crecido
                             control = rpart.control(minsplit = 100, minbucket = 33, maxdepth = 2.8, cp = 0,01))

par(mfrow=c(1,2)); plotcp(arbol_logaut_anova);rpart.plot(arbol_logaut_anova)

######################################################################

quantile(casen_decilyedad$Ingreso_aut_corr, prob=seq(0, 1, length = 11))

quantile(casen_decilyedad$Ingreso_tot_corr, prob=seq(0, 1, length = 11))
