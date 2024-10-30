# Import packages -----------------------------------------------------

library(cowplot)
library(dplyr)
library(ggplot2)
library(sf)
library(showtext)
library(tigris)

# Load Brevard County Shapefile ---------------------------------------

brevard_county <-
  tigris::counties(state = 'FL') %>%
  filter(COUNTYFP == '009')

#### Retrieve main shapefile from 
#### https://fgdl.org/meta/GC_RELIGION.xml

#### Process/filter/clean

# religion <-
#   sf::read_sf('day1_points/data/gc_religion_mar22.shp') %>%
#   # Match CRS
#   sf::st_transform(crs = sf::st_crs(brevard_county)) %>%
#   # Filter to bridges in brevard county
#   sf::st_filter(brevard_county) %>%
#   # Drop geometry to remake from lines to points
#   sf::st_drop_geometry() %>%
#   sf::st_as_sf(coords = c('LONG_DD',
#                           'LAT_DD'),
#                crs = sf::st_crs(brevard_county)) %>%
#   mutate(`Decade Built` = as.character(YR_BUILT %/% 20 *20))
# 

#### Write filtered version to use in map
# st_write(religion,
#          "day1_points/data",
#          "religion",
#          driver = "ESRI Shapefile")

religion <-
  sf::read_sf("day1_points/data/religion.shp") %>%
  rename(`Year Built` = DecdBlt)

# Use Custom Font -------------------------------------------------------

showtext_auto()
font_add_google("Noto Serif")
plotfont <- "Noto Serif"

# Create Map --------------------------------------------------------------

map <-
  ggplot() +
  geom_sf(data = brevard_county, 
          color = 'black',
          fill = '#FFE8D1') +
  geom_sf(
    data = religion,
    aes(
      group = `Year Built`,
      color = `Year Built`
      ),
    alpha = 0.7,
    size = 2,
    shape = 16
  ) +
  scale_color_manual(
    labels = c("1900-1919",
              "1920-1939",
              "1940-1959",
              "1960-1979",
              "1980-1999",
              "2000-2019"),
    values = RColorBrewer::brewer.pal(name = "Reds",
                                      n = 6)
  )+
  theme_void() +
  theme(
    text = element_text(family = plotfont),
    legend.title.align = 0.25,
    plot.title = element_text(hjust = 0.5,
                              color = 'white',
                              size = 24),
    plot.subtitle = element_text(color = 'white',
                                 hjust = 0.5,
                                 size = 18),
    plot.background = element_rect(fill = "#493C29"),
    legend.text = element_text(color = 'white',
                               lineheight = 0.6,
                               size = 18),
    legend.title = element_text(color = 'white',
                                size = 18),
    legend.position = c(0.99, 0.5),
    plot.caption = element_text(color = 'white',
                                hjust = 0.5,
                                size = 14),
    plot.margin = margin(t = 30,
                         r = 15,
                         b = 30,
                         l = 15),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank()
  ) +
  guides(size = 'none') +
  guides(shape = 'none')


# Style and Annotate ------------------------------------------------------

ggdraw() +
  draw_plot(map) +
  draw_text('Give Me That Old Time Religion',
            x = 0.5,
            y = 0.98,
            size = 36,
            family = plotfont,
            color = 'white') +
  draw_text('Houses of Worship by Year of Construction\nin Brevard County, Florida as of 2022',
            x = 0.5,
            y = 0.95,
            size = 24,
            lineheight = 0.25,
            family = plotfont,
            color = 'white') +
  draw_text('2024 30-Day Map Challenge Day 1: Points',
            x = 0.5,
            y = 0.925,
            size = 18,
            family = plotfont,
            color = 'white') +
  draw_text('Alexander Adams',
            x = 0.5,
            y = 0.91,
            size = 18,
            family = plotfont,
            color = 'white') +
  draw_text('Data Source: Florida Geographic Data Library\nTwitter: @alexadams385\nGitHub: AAdams149',
            x = 0.5,
            y = 0.05,
            size = 24,
            family = plotfont,
            color = 'white',
            lineheight = 0.6)

ggsave('day1_points/day1_points.png', width = 2100, height = 2100, units = 'px')
