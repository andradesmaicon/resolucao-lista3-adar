###############################################################################
############################# QUESTÃO 6 #######################################

pacotes <- c("easypackages", "rio", "readr", "readxl", "writexl", "dplyr",
             "microbenchmark", "openxlsx")

library(ncdf4)
library(raster)
library(viridis)
library(fields)
library(easypackages)
libraries(pacotes)

# a) ----------------------------------------------------------------------------------------

# link do arquivo
url_ams_len <- "https://www.dropbox.com/s/w3wp6iwxqex95ep/S_America_model_wtd_v2.nc?dl=1"

file_ams_nc <- file.path(getwd(), "ams_model.nc")

# download dos dados
download.file(
  url = url_ams_len,
  destfile = file_ams_nc,
)

# verifica a existencia do arquivo
file.exists(file_ams_nc)

# abre o arquivo NetCDF
nc_in <- nc_open(filename = file_ams_nc)

# classe
class(nc_in)

print(nc_in)

#b)---------------------------------------------------------------------------

(var_name <- names(nc_in$var))

(var_unidade <- ncatt_get(nc = nc_in, varid = "WTD", attname = "units"))

# c) ---------------------------------------------------------------------------

dados_ncdf_raster <- brick(file_ams_nc)
(dados_ncdf_raster)

# d) ---------------------------------------------------------------------------

data_frame_nc <- as.data.frame(
  x = dados_ncdf_raster,
  xy = TRUE,
  na.rm = TRUE
)

nc_close(nc_in)

# e) alterar o nome das colunas do data frame ---------------------------------
# definindo novos nomes
names_new <- c("wtd","lon", "lat")
# aplicando novos nomes no data frame
names(data_frame_nc) <- names_new
(head(data_frame_nc))

# f) --------------------------------------------------------------------------

# dimensão do quadro de dados
(dim(data_frame_nc))

# dimensão do arquivo raster
(dim(dados_ncdf_raster))

# O número de linhas do quadro de dados não corresponde ao número de células do 
# raster porque quando especificou-se "na.rm = TRUE" os dados faltantes, NAs, são
# ignorados e não são salvos no quadro de dados
