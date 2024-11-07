
library(ggplot2)
library(sf)
library(stringr)
library(dplyr)
library(RColorBrewer)
library(tigris)
library(showtext)
library(cowplot)
options(tigris_use_cache = TRUE)

showtext_auto()
font_add_google("Alike Angular")
plotfont <-
  "Alike Angular"

counties <-
  tigris::counties() %>%
  st_simplify(dTolerance = 3e3) %>%
  st_crop(y = c(xmin = -179.22855,
                ymin = -14.59707,
                xmax = -63,
                ymax = 71.43676)) %>%
  mutate(name_length = nchar(stringr::str_remove_all(NAME," |-"))) %>%
  left_join(
    tigris::fips_codes,
    by = c("STATEFP" = "state_code",
           "COUNTYFP" = "county_code")
  )

states <- state.name
states = states[grep('Alaska|Hawaii',states, invert = TRUE)]

states_bbox <-
  c(xmin = -124.8,
    ymin = -14.59,
    xmax = -63,
    ymax = 50)

lower48 <-
  counties %>%
  filter(!(state_name  %in% c('Alaska',
                              'Hawaii'))) %>%
  st_crop(y = states_bbox) %>%
  ggplot() +
  geom_sf(aes(fill = name_length),
          color = 'black') +
  scale_fill_gradient(name = "# of Characters",
                      low = "#FFFFFF",
                      high = "#00008B") +
  ggtitle("# of Characters in County and County-Equivalent Names in the U.S.",
          subtitle = '2024 30-Day Mapping Challenge Day 3: Polygons\nAlexander Adams') +
  labs(caption = "Data Source: TIGRIS\nGitHub: AAdams149") +
  theme_void() +
  theme(
    text = element_text(family = plotfont),
    plot.background = element_rect(fill = '#FFFFFF'),
    panel.background = element_rect(fill = '#FFFFFF'),
    legend.title.align = 0.1,
    plot.title = element_text(hjust = 0.5,
                              color = 'black',
                              size = 24,
                              lineheight = 0.5),
    plot.subtitle = element_text(color = 'black',
                                 hjust = 0.5,
                                 size = 18),
    legend.box = 'horizontal',
    legend.text = element_text(color = 'black',
                               size = 18),
    legend.title = element_text(color = 'black',
                                size = 18),
    legend.position = c(1.05, 0.3),
    plot.caption = element_text(color = 'black',
                                hjust = 0.5,
                                size = 18,
                                lineheight = 0.5),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank()
  )

alaska_bbox <-
  st_bbox(counties %>% filter(state_name == 'Alaska'))

# alaska_bbox <-
# c('xmin' = -179.22855,
#   'ymin' = 51.17509,
#   'xmax' = -129.97665,
#   'ymax' = 71.43676)

# alaska --------------------------------------------------------------

alaska <-
  counties %>%
  st_crop(y = alaska_bbox) %>%
  ggplot() +
  geom_sf(aes(fill = name_length),
          color = 'black') +
  scale_fill_gradient(
                      low = "#FFFFFF",
                      high = "#00008B") +
  guides(fill = 'none') +
  theme_void() +
  theme(
    text = element_text(family = plotfont),
    plot.background = element_rect(fill = '#FFFFFF'),
    panel.background = element_rect(fill = '#FFFFFF'),
    legend.title.align = 0.5,
    plot.title = element_text(hjust = 0.5,
                              color = 'black',
                              size = 24),
    plot.subtitle = element_text(color = 'black',
                                 hjust = 0.5,
                                 size = 18),
    legend.box = 'horizontal',
    legend.text = element_text(color = 'black',
                               size = 18),
    legend.title = element_text(color = 'black',
                                size = 18),
    legend.position = c(0.87, 0.5),
    plot.caption = element_text(color = 'black',
                                hjust = 0.5,
                                size = 18),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank()
  )


# hawaii --------------------------------------------------------------

hawaii_bbox <-
  c('xmin' = -160.59294,
    'ymin' = 18.91924,
    'xmax' = -154.75717,
    'ymax' = 22.28536)

hawaii <-
  counties %>%
  filter(state_name == 'Hawaii') %>%
  st_crop(y = hawaii_bbox) %>%
  ggplot() +
  geom_sf(aes(fill = name_length),
          color = 'black') +
  scale_fill_gradient(
                      low = "#FFFFFF",
                      high = "#00008B") +
  guides(fill = 'none') +
  theme_void() +
  theme(
    text = element_text(family = plotfont),
    plot.background = element_rect(fill = '#FFFFFF'),
    panel.background = element_rect(fill = '#FFFFFF'),
    legend.title.align = 0.5,
    plot.title = element_text(hjust = 0.5,
                              color = 'black',
                              size = 24),
    plot.subtitle = element_text(color = 'black',
                                 hjust = 0.5,
                                 size = 18),
    legend.box = 'horizontal',
    legend.text = element_text(color = 'black',
                               size = 18),
    legend.title = element_text(color = 'black',
                                size = 18),
    legend.position = c(0.7, 0.5),
    plot.caption = element_text(color = 'black',
                                hjust = 0.5,
                                size = 18),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank()
  )


# draw and save -----------------------------------------------------------


ggdraw() +
  draw_plot(lower48) +
  draw_plot(alaska, x = -0.41, y = 0.225, height = 0.15) +
  draw_plot(hawaii, x = -0.225, y = 0.225, height = 0.11)

ggsave("day3_polygons/day3_polygons.png")
