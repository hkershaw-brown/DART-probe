# Variables
DARTLIB_DIR = dartlib
FORTRAN_MODULE = ice_interp_mod.f90
PYTHON_MODULE = ice_interp

# Default target
all: dartlib pydart

# Step 1: Build dartlib by running quicklib.sh
dartlib:
    cd $(DARTLIB_DIR) && ./quicklib.sh

# Step 2: Build the Python module using f2py
pydart:
    f2py -c -m $(PYTHON_MODULE) $(FORTRAN_MODULE) -L"$(PWD)/$(DARTLIB_DIR)" -ldart -I"$(PWD)/$(DARTLIB_DIR)" --fcompiler=gfortran

# Clean target to remove build artifacts
clean:
    rm -rf __pycache__ *.so *.mod
    cd $(DARTLIB_DIR) && make clean

# Phony targets
.PHONY: all dartlib pydart clean