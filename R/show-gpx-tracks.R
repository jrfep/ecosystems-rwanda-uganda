require(mapview)
require(sf)
require(dplyr)
# depending on the version of GDAL, you might need to use `fgb = TRUE` instead 
mapviewOptions(fgb = FALSE) 
gpx_file <- "~/Desktop/Rwanda-July-2022/data/igishigishigi-trail-nyungwe-forest.gpx"# path and filename
read_sf(gpx_file,'tracks') -> paseo
comments <- read_sf(gpx_file,'waypoints') # %>% select(ele,name,link2_href) 
paseo %>% st_geometry() %>% plot() # check if there is data on the track
mapview(paseo) + mapview(comments)
