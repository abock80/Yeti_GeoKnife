#!/bin/sh
#SBATCH -p UV
#SBATCH -A mows
#SBATCH -n 1
#SBATCH -J GeoKnife                         
#SBATCH --output=%JGeoKnife.out
#SBATCH --time=0-72:00:00
#SBATCH --mail-user=abock@usgs.gov
#SBATCH --mail-type=ALL

srun R --no-save '--args abock R06_hru_z hru_id 2 3 1960 1970' < geoknife.R






