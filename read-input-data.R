#Uganda / Rwanda
#Define area
require(sf)
require(dplyr)
require(readr)
TMWB <- read_sf(sprintf("%s/TM_WORLD_BORDERS-0.3.shp",workdir))

countries <- TMWB %>% st_crop(xmin=28.868332, ymin=-2.759722, xmax=35.009720, ymax=4.222777)
#countries %>% filter(NAME %in% c("Uganda","Rwanda"))
countries %>% st_geometry %>% plot


#point locations:
#plantation / forest calibration points
frst_mgmnt_data <- read_csv(sprintf("%s/forest/global/forest-management/original_crowdsourced_data.csv",gis.data)) %>% filter(!is.na(userid))

frst_mgmnt_xy <- frst_mgmnt_data %>% st_as_sf(coords=c("pixel_center_x","pixel_center_y"),crs=4326)

countries %>% st_intersects(frst_mgmnt_xy)
countries %>% st_geometry %>% plot
frst_mgmnt_xy %>% st_geometry %>% plot(.,add=T)
#splots
(load(sprintf("%s/sPlotOpen.RData",workdir)))
splot_xy <- header.oa %>% st_as_sf(coords=c("Longitude","Latitude"),crs=4326)

countries %>% st_intersects(splot_xy) -> slc
splot_xy %>% slice(unlist(slc)) -> splot_slc
countries %>% st_geometry %>% plot
splot_slc %>% st_geometry %>% plot(.,add=T)

## reservoirs

dams <- read_sf(sprintf("%s/Data/GOOD2_dams.shp",workdir))
countries %>% st_intersects(dams) -> slc
dams %>% slice(unlist(slc)) -> dams_slc

#polygons:
#  alpine areas polygons
alpine <- read_sf(sprintf("%s/global_alpine_30m.shp",workdir))
st_bbox(countries) %>% st_intersects(alpine) -> slc

alpine %>% slice( unlist(slc)) -> alp_areas

countries %>% st_geometry %>% plot(.,border='grey77')
plot(st_geometry(alp_areas),add=T,col=2,border=2)
plot(st_geometry(alpine),add=T,col=2,border=2)

#vegetation rasters:
#  Global PALSAR-2/PALSAR Forest/Non-Forest Map
#ee.ImageCollection("JAXA/ALOS/PALSAR/YEARLY/FNF")

#Animals:
#  gorillas -> globi relationships -> plant species / associations with
#IUCN RLE habitat associations
