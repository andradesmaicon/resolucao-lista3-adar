###############################################################################
############################# QUESTÃO 10 ######################################

pacotes <- c("easypackages", "rio", "readr", "readxl", "writexl", "dplyr",
             "microbenchmark", "openxlsx")

library(ncdf4)
library(raster)
library(viridis)
library(fields)
library(easypackages)
libraries(pacotes)

#--------------------------------------------------------------------------------------------------
# a. Importe os dados para o R, converta-os para *data frame* e verifique o 
# número de colunas e linhas resultantes. 

url_prec_nc <- "https://utexas.app.box.com/v/Xavier-etal-IJOC-DATA?page=2/prec_daily_UT_Brazil_v2.2_20100101_20151231.nc"

file_prec_nc <- file.path(getwd(), "prec_daily_UT_Brazil_v2.2_20100101_20151231.nc")

download.file(
  url = url_prec_nc,
  destfile = file_prec_nc
)

(file.exists(file_prec_nc))

dat_prec_raster <- brick(file_prec_nc)
print(dat_prec_raster)

dat_prec_xy_v <- as.data.frame(
  x = dat_prec_raster,
  xy = TRUE,
  na.rm = TRUE
)

# b. Compare as dimensões do *quadro de dados* com as dimensões do objeto 
# importado, o número de linhas e de colunas do *quadro de dados* correspondem 
# a quais propriedades ou dimensões do objeto importado? Faça essa comparação 
# usando os diferentes valores lógicos para os argumentos `na.rm` e `xy`

dat_prec_xy_f <- as.data.frame(
  x = dat_prec_raster,
  xy = FALSE,
  na.rm = TRUE
)

# xy = TRUE e na.rm = FALSE
dat_prec_xy_fse <- as.data.frame(
  x = dat_prec_raster,
  xy = TRUE,
  na.rm = FALSE
)

# xy = FALSE e na.rm = FALSE
dat_prec_xy_FF <- as.data.frame(
  x = dat_prec_raster,
  xy = FALSE,
  na.rm = FALSE
)

# dimensão do arquivo raster
(dim(dat_prec_raster))
# dimensão do data frame com xy = TRUE e na.rm = TRUE
(dim(dat_prec_xy_v))
# dimensão do data frame com xy = FALSE e na.rm = TRUE
(dim(dat_prec_xy_f))
# dimensão do data frame com xy = TRUE e na.rm = FALSE
(dim(dat_prec_xy_fse))
# dimensão do data frame com xy = FALSE e na.rm = FALSE
(dim(dat_prec_xy_FF))

# O arquivo raster tem 162 linhas, 168 colunas e 2191 camadas. Quando definimos
# xy = TRUE e na.rm = FALSE o número de linhas do data frame é definido como
# 162 x 168, o número de colunas é definido pelo número de camadas do arquivo 
# raster, se xy = FALSE, o número de colunas é idêntico ao de camadas, 2191,
# caso contrário será maior.




