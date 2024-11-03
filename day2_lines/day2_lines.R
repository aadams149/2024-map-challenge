
library(ggplot2)
library(sf)
library(cowplot)
library(showtext)
library(dplyr)

tlh <-
  sf::st_read("day2_lines/data/Roadway_Functional_Classification.shp")

showtext_auto()
font_add_google("Cormorant")
plotfont <- "Cormorant"

map <-
ggplot(tlh) +
  geom_sf(aes(color = FUNCTION)) +
  scale_color_manual(name = "",
                     values = RColorBrewer::brewer.pal(10, "Set3")) +
  theme_void() +
  theme(
    text = element_text(family = plotfont),
    plot.title = element_text(hjust = 0.5,
                              color = 'white',
                              size = 24),
    plot.subtitle = element_text(color = 'white',
                                 hjust = 0.5,
                                 size = 18),
    plot.background = element_rect(fill = "#493C29"),
    legend.text = element_text(color = 'white',
                               lineheight = 0.2,
                               size = 10),
    legend.title = element_text(color = 'white',
                                size = 0,
                                hjust = 0.5),
    legend.position = c(0.4, 0.62),
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
  guides(shape = 'none') +
  guides(color = guide_legend(ncol = 2))

legend <- cowplot::get_legend(map)

legend$widths[2] <- unit(0, "points")

map <-
  map +
  theme(legend.position = "none")

ggdraw() +
  draw_plot(map) +
  draw_text('Rainbow Road',
            x = 0.3,
            y = 0.95,
            size = 36,
            family = plotfont,
            color = 'white') +
  draw_text('Roads in Tallahassee, Florida by Function as of 2024',
            x = 0.3,
            y = 0.91,
            size = 28,
            lineheight = 0.25,
            family = plotfont,
            color = 'white') +
  draw_text('2024 30-Day Map Challenge Day 2: Lines',
            x = 0.3,
            y = 0.87,
            size = 24,
            family = plotfont,
            color = 'white') +
  draw_text("Function",
            x = 0.3,
            y = 0.78,
            size = 24,
            family = plotfont,
            color = "white")+
  draw_line(x = c(0.23,0.25),
            y = c(0.74,0.74),
            color = RColorBrewer::brewer.pal(10,"Set3")[1]) +
  draw_text(unique(tlh$FUNCTION)[1],
            x = 0.30,
            y = 0.74,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.71,0.71),
            color = RColorBrewer::brewer.pal(10,"Set3")[2]) +
  draw_text(unique(tlh$FUNCTION)[2],
            x = 0.305,
            y = 0.71,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.68,0.68),
            color = RColorBrewer::brewer.pal(10,"Set3")[3]) +
  draw_text(unique(tlh$FUNCTION)[3],
            x = 0.2975,
            y = 0.68,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.65,0.65),
            color = RColorBrewer::brewer.pal(10,"Set3")[4]) +
  draw_text(unique(tlh$FUNCTION)[4],
            x = 0.3,
            y = 0.65,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.62,0.62),
            color = RColorBrewer::brewer.pal(10,"Set3")[5]) +
  draw_text(unique(tlh$FUNCTION)[5],
            x = 0.34,
            y = 0.62,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.59,0.59),
            color = RColorBrewer::brewer.pal(10,"Set3")[6]) +
  draw_text(unique(tlh$FUNCTION)[6],
            x = 0.323,
            y = 0.59,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.56,0.56),
            color = RColorBrewer::brewer.pal(10,"Set3")[7]) +
  draw_text(unique(tlh$FUNCTION)[7],
            x = 0.3205,
            y = 0.56,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.53,0.53),
            color = RColorBrewer::brewer.pal(10,"Set3")[8]) +
  draw_text(unique(tlh$FUNCTION)[8],
            x = 0.323,
            y = 0.53,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.50,0.50),
            color = RColorBrewer::brewer.pal(10,"Set3")[9]) +
  draw_text(unique(tlh$FUNCTION)[9],
            x = 0.3265,
            y = 0.50,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_line(x = c(0.23,0.25),
            y = c(0.47,0.47),
            color = RColorBrewer::brewer.pal(10,"Set3")[10]) +
  draw_text(unique(tlh$FUNCTION)[10],
            x = 0.298,
            y = 0.47,
            size = 18,
            family = plotfont,
            color = "white") +
  draw_text('Alexander Adams',
            x = 0.3,
            y = 0.83,
            size = 24,
            family = plotfont,
            color = 'white') +
  draw_text('Data Source: Tallahassee-Leon County GIS\nTwitter: @alexadams385\nGitHub: AAdams149',
            x = 0.5,
            y = 0.05,
            size = 36,
            family = plotfont,
            color = 'white',
            lineheight = 0.6)

ggsave('day2_lines/day2_lines.png', width = 2100, height = 1400, units = "px")
