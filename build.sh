#!/bin/bash

PREFIX="kodbasen"
IMAGE="groovy-arm"
VERSION="2.4.7"

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RESOURCEDIR="$BASEDIR/resources"

echo " ____ ____ ____ ____ ____ ____ ____ ____ ";
echo "||k |||o |||d |||b |||a |||s |||e |||n ||";
echo "||__|||__|||__|||__|||__|||__|||__|||__||";
echo "|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|";
echo "                                         ";
echo "Building Groovy $VERSION Image for ARM.  ";

if [ ! -d "$RESOURCEDIR" ]; then
  mkdir $RESOURCEDIR && cd $RESOURCEDIR
  curl -sSLk -o groovy.zip https://dl.bintray.com/groovy/maven/apache-groovy-binary-$VERSION.zip  
  unzip groovy.zip
  mv groovy-$VERSION groovy
  rm groovy.zip
  cd $BASEDIR
fi

rm -f $BASEDIR/Dockerfile
cp $BASEDIR/Dockerfile.template $BASEDIR/Dockerfile
sed -i -e "s;groovy.version;$VERSION;" "Dockerfile"

docker build --rm --no-cache -t $PREFIX/$IMAGE:$VERSION .
docker tag $PREFIX/$IMAGE:$VERSION $PREFIX/$IMAGE:latest


docker push $PREFIX/$IMAGE:$VERSION
docker push $PREFIX/$IMAGE:latest

