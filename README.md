# Notes on `apptainer`

## Example: creating a Julia image

E.g. I needed to add make, g++ to the Julia, here is how:

```
module load apptainer
```

put the following into a file called `myjulia.def`:

```
BootStrap: docker
From: julia

%post
    export DEBIAN_FRONTEND=noninteractive
    export TZ=Etc/UTC

    apt-get -y update

    apt-get install -y procps
    apt-get install -y git
    apt-get install -y build-essential
    apt-get install -y g++
```

then: `apptainer build myjulia.sif myjulia.def`

You can then test the image with `apptainer shell --cleanenv myjulia.sif`. Note the `--cleanenv` flag, which prevents the child to inherit environment variables. Without that, Stan targets in Pigeons did not work.

## Using in nextflow

The simplest route is to add the option `-with-apptainer myjulia.sif`. Note that by default, in contrast to `apptainer shell ..`, when called by nextflow it will do the right thing and not pass env variables.

It is wise though to override the default depot as it may e.g. contain a julia start up file loading Revise creating problems. This can be accomplished with an input env to the process. 
