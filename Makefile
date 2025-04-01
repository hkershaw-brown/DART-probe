# Variables
DARTLIB_DIR = dartlib
FORTRAN_MODULE = ice_interp_mod.f90
PYTHON_MODULE = ice_interp
LIBDART_LINK = libdart.so

# Default target
all: dartlib link pydart

# Step 1: Build dartlib by running quicklib.sh
dartlib:
	cd $(DARTLIB_DIR) && ./quicklib.sh

# Step 2: Create a symbolic link to dartlib/libdart.so
link:
	ln -sf $(DARTLIB_DIR)/libdart.so $(LIBDART_LINK)

# Step 3: Build the Python module using f2py
pydart:
	f2py -c -m $(PYTHON_MODULE) $(FORTRAN_MODULE) -L"$(PWD)/$(DARTLIB_DIR)" -ldart -I"$(PWD)/$(DARTLIB_DIR)" --fcompiler=gfortran

# Clean target to remove build artifacts and symbolic link
clean:
	rm -rf __pycache__ *.so *.mod $(LIBDART_LINK)
	cd $(DARTLIB_DIR) && make clean

# Phony targets
.PHONY: all dartlib link pydart clean