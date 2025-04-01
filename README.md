## Using python to call DART

To build DART, set DART in dartlib/quicklib.sh to whereever your DART repo is

e.g.

```
main() {

export DART="/Users/hkershaw/DART/Projects/Interpolation/DART"
source "$DART"/build_templates/buildfunctions.sh
```

Note the model programs listed in quicklib.sh will need to match the 
programs for your model.  These will not be built, just ignored for
compiling libdart.so

Use the mkmf.template in this directory to build dart with -fPIC

The build libdart.so, and the python wrapper by running 

```
make 
```

