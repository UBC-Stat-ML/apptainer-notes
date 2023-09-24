## Using an image in a nextflow script

Pick one of the images below (make sure to follow the link to get the latest tag version):

- [Default image](https://hub.docker.com/r/alexandrebouchardcote/default): a default image covering as much as possible the software requirements of our nextflow scripts (julia, build tools, etc) `docker://alexandrebouchardcote/default:0.1.3`
- [Blang image](https://hub.docker.com/r/alexandrebouchardcote/blang): to run the Blang CLI `docker://alexandrebouchardcote/blang:0.0.0`

then there are several ways to instruct nextflow to use it for one or all 
processes in a nextflow script.

### For quick testing

```
load module apptainer
./nextflow run myNextFlowFile.nf -with-apptainer docker://alexandrebouchardcote/default:0.1.3
```

### Integration into the script

For reproducibility, it is better to specify the docker container in the nextflow configuration 
files. 

TODO

### Logging into the container

Useful for debugging:

```
load module apptainer
apptainer shell docker://alexandrebouchardcote/default:0.1.3
```


## Creating/improving an image

- Sign up to the free docker hub account. 
- Download docker desktop
- Edit `push.sh` so that `docker_username=..` matches with your docker hub username.

Then in order to create images that will work both on Apple Silicon and x86, follow these steps (from 
https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/ )

1. Duplicate the folder `default`, give it a meaningful name, denoted `mycontainer` in the following, and modify its Dockerfile as needed
2. `cd mycontainer`
3. Test the build with `docker build .`
4. Once it works, commit and push, `cd ..`, then `./push.sh mycontainer 0.0.0`. This will tag your git and push multiplatform images to Dockerhub (so that even if you prepare the image on a mac with Apple Silicon, it will work on x86 seemlessly)


### Misc tips when creating an image

- To login interactively in docker:
```
docker build -t temp .
docker run -ti temp:latest bash
```
