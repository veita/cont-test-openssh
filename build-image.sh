#!/bin/bash

set -ex

cd "${0%/*}"

BASE_IMAGE="veita/debian-base:latest"
GIT_COMMIT=$(git describe --always --tags --dirty=-dirty)

CONT=$(buildah from ${BASE_IMAGE})

buildah copy $CONT etc/ /etc
buildah copy --chmod 755 $CONT bin/entrypoint.sh /bin/entrypoint.sh
buildah copy --chmod 755 $CONT bin/report-known-hosts.sh /bin/report-known-hosts.sh
buildah copy $CONT root/ /root
buildah copy $CONT setup/ /setup
buildah run $CONT /bin/bash /setup/setup.sh
buildah run $CONT rm -rf /setup

buildah config --workingdir '/' $CONT
buildah config --cmd '["/bin/entrypoint.sh"]' $CONT

buildah config --port 22/tcp $CONT

buildah config --author "Alexander Veit" $CONT
buildah config --label commit=${GIT_COMMIT} $CONT

buildah commit --rm $CONT localhost/test-openssh:latest
