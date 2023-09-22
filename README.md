# Notes on container pipeline for the group

## Using an image in a nextflow script

Pick one of the images below:

- [Test image containing Julia only](https://hub.docker.com/r/alexandrebouchardcote/test/tags): `docker://alexandrebouchardcote/test:multi`

then there are several ways to instruct nextflow to use it for one or all 
processes in a nextflow script.

### For quick testing

```
load module apptainer
./nextflow run myNextFlowFile.nf -with-apptainer docker://alexandrebouchardcote/test:multi
```

### Integration into the script

For reproducibility, it is better to specify the docker container in the nextflow configuration 
files. 

TODO


## Creating/improving an image

- Sign up to the free docker hub account. Use a username that will clearly link your account to you if possible (e.g. same as github if available)
- Download docker desktop

Then in order to create images on an Apple Silicon machine that run on x86, follow these steps (from 
https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/ )

1. Create a directory with a file name `Dockerfile` in it with contents specifying how to build the image, e.g. a minimal one I used:
```
FROM julia
RUN echo OK
```
2. cd into the directory containing the Dockerfile
3. enable multiplatform builds with `docker buildx create --use`
4. build and push (has to be done together for multiplatform builds?): replace 'alexandrebouchardcote' by your docker username, 'test' by the repo
```
docker buildx build --platform linux/amd64,linux/arm64 -t alexandrebouchardcote/test:multi --push  .
```

TODO: maybe some polishing to link up to a github repo with the Docker file?

# Old

Ended up having to change the pipeline compare to what's below because could not get 
the publishing of image files work with github actions (tried instructions based on 
https://hsf-training.github.io/hsf-training-singularity-webpage/09-bonus-episode/index.html and
https://linuxhit.com/how-to-create-docker-images-with-github-actions/ both failed). 

Looked into open source hubs and they seem less likely to survive in the medium term 
compared to Docker hub. So we need to go the Docker route to *create* containiner 
(more standard anyways, more doc, can be done on laptop easily, etc), but we will still 
use apptainer to run the container on the server.


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
