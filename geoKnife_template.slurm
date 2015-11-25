#!/bin/sh
#SBATCH -p UV
#SBATCH -A mows
#SBATCH -n 1
#SBATCH -J GeoKnife                         
#SBATCH --output=%JGeoKnife.out
#SBATCH --time=0-72:00:00
#SBATCH --mail-user=userName@usgs.gov
#SBATCH --mail-type=ALL

srun R --no-save '--args userName Shape Attribute Climate Variable POR1 POR2' < geoknife.R






