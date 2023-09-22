## Using an image in a nextflow script

Pick one of the images below:

- [Default image](https://hub.docker.com/r/alexandrebouchardcote/default): a default image covering as much as possible the software requirements of our nextflow scripts (julia, build tools, etc) `docker://alexandrebouchardcote/default:latest`

then there are several ways to instruct nextflow to use it for one or all 
processes in a nextflow script.

### For quick testing

```
load module apptainer
./nextflow run myNextFlowFile.nf -with-apptainer docker://alexandrebouchardcote/default:latest
```

### Integration into the script

For reproducibility, it is better to specify the docker container in the nextflow configuration 
files. 

TODO


## Creating/improving an image

- Sign up to the free docker hub account. 
- Download docker desktop

Then in order to create images on an Apple Silicon machine that run on x86, follow these steps (from 
https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/ )

1. Duplicate the folder `default`, give it a meaningful name, denoted `mycontainer` in the following, and modify its Dockerfile as needed
2. `cd mycontainer`
3. Test the build with `docker build .`
4. Once it works, commit and push, `cd ..`, then `./push.sh mycontainer 0.0.0`. This will tag your git and push multiplatform images to Dockerhub (so that even if you prepare the image on a mac with Apple Silicon, it will work on x86 seemlessly)


### Misc tips when creating an image

TODO
