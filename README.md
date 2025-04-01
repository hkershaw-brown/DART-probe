## Using python to call DART

To build DART, set DART in dartlib/quickbuild.sh to whereever your DART repo is

e.g.

```
main() {

export DART="/Users/hkershaw/DART/Projects/Interpolation/DART"
source "$DART"/build_templates/buildfunctions.sh
```

Use the mkmf.template in this directory to build dart with -fPIC

The build libdart.so, and the python wrapper by running 

```
make 
```

Current issues:
- seems to be crashing the kernel when reading the namelist. Work around for this interpolation
 code is not calling namelist read. 
