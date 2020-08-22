# example-service with common chart library

## Check your template

after modification to common chart rendering can be tested af follow.

```bash
cd helm/example-service/
rm -rf charts/common; cp -r ../common charts/ && helm template . 
```

## Debug the chart (example)

```bash
cd helm
namespace=test
helm dep up ./example-service/
helm upgrade --install  ${namespace}-example-service ./example-service/  --debug --dry-run --namespace ${namespace}
```

## Install the chart (example)

```bash
cd helm
namespace=test
helm dep up ./example-service/
helm upgrade --install  ${namespace}-example-service ./ --debug  --namespace ${namespace}
```

