#Uganda / Rwanda

# Could alternatively use module loads before starting R
#source('/apps/modules/module/4.6.0/init/r.R')
#module('add', 'udunits/2.2.26', 'python/3.9.9', 'perl/5.28.0', 'gdal/3.4.1',
#       'proj4/5.1.0', 'spatialite/5.0.1', 'geos/3.10.2', 'sqlite/3.31.1')
# library(withr)
# with_makevars(
#  list(LDFLAGS=paste(
#  '-Wl,-rpath=', Sys.getenv("GDAL_ROOT"), '/lib ',
#  '-Wl,-rpath=', Sys.getenv("PROJ_ROOT"), '/lib ',
#  '-Wl,-rpath=', Sys.getenv("GEOS_ROOT"), '/lib64 ',
#  '-Wl,-rpath=', Sys.getenv("SQLITE_ROOT"), '/lib ',
#  '-Wl,-rpath=', Sys.getenv("SPATIALITE_ROOT"), '/lib ',
#  '-Wl,-rpath=', Sys.getenv("UDUNITS_ROOT"), '/lib ',
#  sep=''), MAKEFLAGS='-j'),
#  (function() {
#  install.packages('sf', configure.args=c("LIBS=-L${SQLITE_ROOT}/lib"))
#  install.packages('tmap', configure.args=c("LIBS=-L${SQLITE_ROOT}/lib"))
#  })()
#)

#install.packages('sf')
#install.packages('raster')


module add sqlite/3.31.1 spatialite/5.0.1 python/3.9.9 perl/5.28.0 gdal/3.4.1 geos/3.10.2
module add proj4/5.1.0 udunits/2.2.26

#Define area
mkdir /srv/scratch/$USER/ecosystems-rwanda-uganda
cd /srv/scratch/$USER/ecosystems-rwanda-uganda
GISDATA=/srv/scratch/cesdata/gisdata
unzip -u $GISDATA/admin/global/TMWB/TM_WORLD_BORDERS_SIMPL-0.3.zip

#point locations:
# gps tracks
ogrinfo $HOME/proyectos/UNSW/ecosystems-rwanda-uganda/hiking-mount-bisoke.gpx

#plantation / forest calibration points
#splots
unzip -u $GISDATA/vegetation-plots/global/sPlotOpen/sPlotOpen.zip
unzip -u sPlotOpen.RData\(2\).zip


## reservoirs
unzip -u $GISDATA/hydrology/global/GOODD-2020/GOODD_data.zip
ls $GISDATA/hydrology/global/HydroLAKES
ogrinfo $GISDATA/hydrology/global/HydroLAKES/HydroLAKES_polys_v10.gdb

ogrinfo $GISDATA/hydrology/global/HydroLAKES/HydroLAKES_polys_v10.gdb -geom=no -sql "SELECT Hylak_id,Lake_name,Country,Poly_src,Lake_type,Grand_id,Lake_area FROM \"HydroLAKES_polys_v10\" LIMIT 2"


#polygons:
#  alpine areas polygons

unzip -u $GISDATA/cryosphere/global/Alpine-biomes/Global-alpine-biomes.zip
unzip -u global_alpine_30m.zip

#vegetation rasters:
#  Global PALSAR-2/PALSAR Forest/Non-Forest Map
#ee.ImageCollection("JAXA/ALOS/PALSAR/YEARLY/FNF")
#gdalwarp $GISDATA/forest/global/PALSAR-forest-non-forest/FNF2020.vrt -te 28.868332 -2.759722 35.009720 4.222777 PALSAR_FNF2020.tif
gdalwarp $GISDATA/forest/global/PALSAR-forest-non-forest/FNF2020.vrt -te 29.3 -1.6 29.8 -0.7 PALSAR_FNF2020.tif


#MAcrogroups:
unzip -u $GISDATA/vegetation/regional/IVC-EcoVeg/Africa/af_labeled_ecosys.zip

gdalwarp Africa_IVC_20130316_final_MG.tif -te 28.868332 -2.759722 35.009720 4.222777 IVC_macrogroups.tif

#Animals:
#  gorillas -> globi relationships -> plant species / associations with
#IUCN RLE habitat associations
