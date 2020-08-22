#!/usr/bin/env bash
set -ex

# This script use the example-service as a template to generate helm chart
DEPLOYER=${DEPLOYER:-'skymaster-deployer'}
DEPLOYER_EMAIL=${DEPLOYER_EMAIL:-'deploy@skymaster.io'}
CHART_REPO=${CHART_REPO:-'skymaster-helm'}


if [[ -z "${service}"  ]]
then
    echo "environment '${service}' is missing"
    exit 1
fi

if [[ -z "${version}"  ]]
then
    echo "environment '${version}' is missing"
    exit 1
fi

echo "helming ${service}"

if [[ ! -d "${service}" ]]
then
	cp -r example-service ${service}
    cd ${service}
    grep -rl example-service . |xargs sed -i "s#example-service#${service}#g"
    echo "rendering test"
    helm dep up .
    helm template .
    git add .
    git config user.name ${DEPLOYER}
    git config user.email ${DEPLOYER_EMAIL}
    git commit -m "Auto chart create"
    git status
    git push origin HEAD:master
    cd ..
fi
helm dep up ./${service}/
helm package ${service}/ -u --version=${version} --app-version=${version}
helm push ./${service}-${version}.tgz ${CHART_REPO} --force
rm ${service}-${version}.tgz
