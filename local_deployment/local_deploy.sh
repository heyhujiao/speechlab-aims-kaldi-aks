#!/bin/bash
set -eu

# installing helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get >/tmp/install-helm.sh
chmod u+x /tmp/install-helm.sh
/tmp/install-helm.sh

export KUBE_NAME=kaldi-feature-test
export NAMESPACE=kaldi-test

# prompt to put the models in the models directory
NUM_MODELS=$(find ./models/ -maxdepth 1 -type d | wc -l)
if [ $NUM_MODELS -gt 1 ]; then
    echo "Speech Recognition models detected"

    sudo cp -r ./models/ /opt/models
    sudo swapoff -a
    strace -eopenat kubectl version
    echo -e '\033[0;32mModels copied to mount directory!\n\033[m'
else
    printf "\n"
    printf "##########################################################################\n"
    echo "Please put at least one model in the ./models directory before continuing"
    printf "##########################################################################\n"

    exit 1
fi

exit 0