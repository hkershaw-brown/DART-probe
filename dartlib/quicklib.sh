#!/usr/bin/env bash

# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

main() {


#export DART="/Users/hkershaw/DART/Projects/Interpolation/DART"
export DART="/Users/hkershaw/DART/issues/large_interp_residual/DART"
source "$DART"/build_templates/buildfunctions.sh

# replace relative paths in &preprocess namelist
sed -i '' "s|\.\./\.\./\.\.|$DART|g" input.nml

MODEL=MOM6
LOCATION=threed_sphere

programs=(
filter
)

# quickbuild arguments
arguments "$@"

# clean the directory
\rm -f -- libdart.so *.o *.mod Makefile .cppdefs

# build any NetCDF files from .cdl files
cdl_to_netcdf

# build and run preprocess before making any other DART executables
buildpreprocess

# build static library
buildlib  libdart.so

# clean up
\rm -f -- *.o 

}

main "$@"
