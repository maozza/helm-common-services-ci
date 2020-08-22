# Service example with common chart library

## Description

this repository can be use to easily create helm-charts with the use of common chart.

## How to use

the `./build.sh` script can be use on CI tool to generate new helm chart that uses the common chart.
it will create new chart if the ${service} not exists and push it to git (make sure to have the right credentials for git repository).
if the chart exists, it will only update the version of the chart and push it to the git repository
the scripts `./build.sh` assume that `${service}` and `${version}` environment variable is exists and fail if not.

```bash
export service=my-service
export version=my-service-version
./build.sh
```

## Thinks to know

make sure to change the example-service Chart.yaml repository or version if requires.

```bash
dependencies:
  - name: common
    version: 0.0.1
    repository: file://../common
```

### Check your template

after modification to common chart rendering can be tested af follow:

```bash
cd helm/example-service/
rm -rf charts/common; cp -r ../common charts/ && helm template . 
```

after generating the chart, we are ready to deploy our chart. Before installing, it is worth checking the rendered template first.
 
 ```bash
cd helm
namespace=test
helm dep up ./my-service/
helm upgrade --install  ${namespace}-my-service ./my-service/  --debug --dry-run --namespace ${namespace}
```