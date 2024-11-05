
library(ggplot2)
library(sf)
library(stringr)
library(dplyr)
library(RColorBrewer)
library(tigris)
options(tigris_use_cache = TRUE)

bbox <-
  c(xmin = )

counties <-
  tigris::counties() %>%
  tigris::shift_geometry() %>%
  st_transform(crs = st_crs(4326))
  mutate(name_length = nchar(stringr::str_remove_all(NAME," |-"))) %>%
  st_crop(y = )

map <-
  ggplot() +
  geom_sf(
    data = counties,
    aes(
     fill = name_length
    ))+
  theme_void()
