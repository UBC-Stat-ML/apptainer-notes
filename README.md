# apptainer-notes

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
