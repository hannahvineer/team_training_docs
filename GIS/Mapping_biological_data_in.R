# A primer in Geographic Information System mapping in R
# Author: Hannah Vineer
# Last updated: 05/07/2024

# This is a live resource - I will add to it from time to time

# Contents ---------------------------------------------------------------------
# 0. Dummy data and R packages
# 1. Mapping study/sampling locations
# 2. Pie map
# X. Useful external resources

# 0. Dummy data and R packages -------------------------------------------------

# Install and load required packages ====
install.packages("rgbif")
install.packages("CoordinateCleaner")
install.packages("dplyr")
install.packages("rnaturalearth")
install.packages("ggplot2")
install.packages("terra")
install.packages("tidyterra")
install.packages("rworldmap")
install.packages("rworldxtra")

library(rgbif)
library(CoordinateCleaner)
library(dplyr)
library(rnaturalearth)
library(ggplot2)
library(terra)
library(tidyterra)
library(rworldmap)
library(rworldxtra)

# Get some dummy species occurrence data: ==== 

# Get quokka occurrence data from GBIF
quokka_data = occ_search(scientificName = "Setonix brachyurus")

# I find data frames easier to use than tibbles, so extract data from the occurrence data
quokka_df = as.data.frame(quokka_data$data)

# Select relevant columns
quokka_cleaned <- quokka_df %>%
  select(scientificName, decimalLatitude, decimalLongitude, countryCode, year, month, day, basisOfRecord, institutionCode)

# Remove rows with missing coordinates
quokka_cleaned <- quokka_cleaned %>%
  filter(!is.na(decimalLatitude) & !is.na(decimalLongitude))

# Clean the coordinates using CoordinateCleaner
# See ??clean_coordinates for options
# This dataset throws up an important issue. Quokka are endemic to a small island off the West coast of Australia. 
# If I include "seas" in the tests, most of the records are returned as problematic.
quokka_cleaned = as.data.frame(clean_coordinates(quokka_cleaned, 
                  lon = "decimalLongitude", 
                  lat = "decimalLatitude",
                  species = "scientificName",
                  tests = c("capitals", "centroids", 
                            "institutions",
                            "equal", "zeros")))

# Filter the cleaned data (because the step above just flags records for later filtering)
quokka_cleaned <- quokka_cleaned %>% 
  filter(.summary == TRUE) %>%
  select(-.summary)

# Get country boundary ====
# Use the rnaturalearth package to get country boundary for mapping
# I've specified returnclass = "sv" for compatibility with the terra package
oz = ne_countries(country = "Australia", returnclass = "sv") 

# Using your own data ====

# If you would like to use this script to map your own data, you can read your data in as a .csv file
# your file must contain columns for the latitude, longitude as a minimum.
# Example:
#     my_occ_dat = read.csv("DIRECTORY PATH/FILENAME.csv")

# You can then read your boundary file in as a shapefile
# Example:
#   my_bnd = vect("DIRECTORY PATH/FILENAME")

# 1. Mapping study/sampling locations ------------------------------------------

# You can plot sv class boundaries using terra::plot
plot(oz, col = "grey")
plot(oz, col = "antiquewhite")
plot(oz, col = "antiquewhite", background = "aliceblue", xlab = "Longitude", ylab = "Latitude")

# Then overlay points
# You first need to create a spatial object (SpatVector) from the point data
quokka_vector <- terra::vect(quokka_cleaned, geom = c("decimalLongitude", "decimalLatitude"))
points(quokka_vector, cex = 0.5, col = "black")
north(xy = "topleft") # add north arrow
sbar(500, xy = "bottomleft", label="500km", cex = 0.7)

# If you prefer ggplot for visualisations, check out the tidyterra package

# 2. Pie map ---------------------------------------------------------------

# For this example, we're going to assume that each point in the quokka dataset
# is not a single individual, but a group of individuals. We're going to assign a
# proportion infected to each group.

quokka_inf = quokka_cleaned
quokka_inf$Positive = runif(n = length(quokka_inf[,1]), min = 0, max = 1) # I am fully aware that disease data do not follow uniform distributions. This is to produce dummy data for training purposes only. 
quokka_inf$Negative = 1-quokka_inf$Positive
quokka_inf = quokka_inf %>% sample_n(5)
mapPies(quokka_inf, nameX="decimalLongitude", nameY="decimalLatitude", 
        nameZs=c("Positive", "Negative"), 
        oceanCol = "aliceblue", landCol = "antiquewhite",
        xlim = c(115, 116), ylim = c(-33, -31), 
        symbolSize = 3, zColours = c("red", "grey"))

# You can immediately see problems with this method. Pies are overlapping, 
# Rottnest island is not included on the underlying map, plus the general
# critique of pice charts (https://theconversation.com/heres-why-you-should-almost-never-use-a-pie-chart-for-your-data-214576)
# Is simply show this because it is a common way of presenting disease data, or 
# allele frequencies in spatial populations. You can also map pie charts using the
# geopandas package in Python. 

# X. Useful external resources -------------------------------------------------

# https://rspatial.org/index.html 
