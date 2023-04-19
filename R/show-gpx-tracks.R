require(mapview)
require(sf)
require(dplyr)
# depending on the version of GDAL, you might need to use `fgb = TRUE` instead 
mapviewOptions(fgb = FALSE) 

#gpx_file <- "~/Desktop/Rwanda-July-2022/data/igishigishigi-trail-nyungwe-forest.gpx"# path and filename
gpx_dir <- "~/Desktop/Rwanda-July-2022/field-work/gpx-hook/"
#  gpsbabel -t -i gpx -f Current.gpx -x track,split,title="ACTIVE LOG # %Y%m%d" -o gpx -F out.gpx
# exiftool -common -GPSVersionID -GPSImgDirection -GPSImgDirectionRef -GPSLatitude -GPSLatitudeRef -GPSLongitude -GPSLongitudeRef -GPSPosition -GPSStatus -n -csv /Volumes/Teradactylo/Fototeca/Ordenados/2022/07/20220713/ > ~/Desktop/Rwanda-July-2022/field-work/fotos_13-07-22.csv

require(readr)

fotos <- read_csv("~/Desktop/Rwanda-July-2022/field-work/fotos_13-07-22.csv")

fotos %>% slice(1:10) %>% print.AsIs()
fotos %>% filter(!is.na(GPSPosition)) %>% select(FileName, DateTimeOriginal, GPSImgDirection, GPSImgDirectionRef, GPSLatitude, GPSLongitude) %>% st_as_sf( coords = c("GPSLongitude", "GPSLatitude"), crs="EPSG:4326") -> fotos_xy


for (j in dir(gpx_dir,full.names=T)) {
  if (grepl("Waypoints",j)) {
    wpts <- read_sf(j,'waypoints')
    assign(strsplit(basename(j),'-')[[1]][1],wpts)
  } else {
    track <- read_sf(j,'tracks')
    assign(strsplit(basename(j),'-')[[1]][1],track)
  }
}

Waypoints_13 %>% st_geometry() %>% plot()
out.gpx %>% st_geometry() %>% plot(.,add=T) # check if there is data on the track
mapview(out.gpx %>% slice(1)) + mapview(Waypoints_13 %>% select(name,ele,time)) + mapview(fotos_xy)


gpx_file <- "~/Desktop/Rwanda-July-2022/field-work/gpx-bare/Track_11-JUL-22 095247 PM.gpx"
read_sf(gpx_file,'tracks') -> Bisoke_track
gpx_file <- "~/Desktop/Rwanda-July-2022/field-work/gpx-bare/Waypoints_11-JUL-22.gpx"
Bisoke_wpts <- read_sf(gpx_file,'waypoints')
Bisoke_wpts %>% st_geometry() %>% plot()
Bisoke_track %>% st_geometry() %>% plot(.,add=T) # check if there is data on the track
mapview(Bisoke_track) + mapview(Bisoke_wpts)
