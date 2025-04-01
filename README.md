## Using python to call DART


* Build DART as a library, example mkmf.template in this directory, 

Compile wrapper module, link to DART library libdart.so

f2py -c -m ice_interp ice_interp_mod.f90 -L/Users/hkershaw/DART/Projects/Interpolation/DART/models/cice/work -ldart -I/Users/hkershaw/DART/Projects/Interpolation/DART/models/cice/work --fcompiler=gfortran



