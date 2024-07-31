#!/bin/bash
set -e

EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` [container, e.g. default] [tag]"
  exit 1
fi

container=$1
tag=$2
docker_username="${DOCKER_USERNAME:-alexandrebouchardcote}"

function is_git_clean {

  mods=`git status --porcelain | tail -n 1`
  if [ "${#mods}" -gt "0" ]
  then
    return 1 # false
  else
    return 0 # true
  fi

}

# return 1 (true) if the git repo is up to date with remote, 0 (false) otherwise
function is_git_remote_up_to_date {

  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})

  if [ $LOCAL = $REMOTE ]
  then
      return 0
  else
      return 1
  fi

}

if ! [ -f "push.sh" ]; then
  echo "Run from root of the containers repo"
  exit 1
fi

echo "Checking everything is committed.."
if ! is_git_clean
then
  echo "Make sure everything is committed in the project dir before releasing artifacts"
  exit 1
fi

echo "Checking everything is committed.."
if ! is_git_remote_up_to_date
then
  echo "Make sure to git pull before releasing artifacts"
  exit 1
fi

# tag the git repo
# this will stop the script if tag already exists
git tag -a ${container}_${tag} -m "Automatic tag for $container:$tag"

# perform docker operation
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -t $docker_username/$container:$tag --push $container

# push the tag to git 
git push --tags
