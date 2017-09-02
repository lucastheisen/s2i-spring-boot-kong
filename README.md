# Spring Boot behind Kong


## Install this Builder
### powershell
```powershell
$url = 'https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/sti.yaml -OutFile $env:TEMP\sti.yaml
oc create -f $env:TEMP\sti.yaml
```
### bash
```bash
url='https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
curl $url/sti.yaml | oc create -f -
```

## Install Kong
### powershell
```powershell
$url = 'https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/kong.yaml -OutFile $env:TEMP\kong.yaml
oc process -f $env:TEMP\kong.yaml `
    --param "APP_NAME=kong" `
    --param "DATABASE_USERNAME=kong" `
    --param "DATABASE_PASSWORD=kong" | `
    oc apply -f -
```
### bash
```bash
url='https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
curl $url/kong.yaml | oc process -f - \
    --param "APP_NAME=kong" \
    --param "DATABASE_USERNAME=kong" \
    --param "DATABASE_PASSWORD=kong" | \
    oc apply -f -
```
## Install MongoDB
### powershell
```powershell
$url = 'https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/mongodb.yaml -OutFile $env:TEMP\mongodb.yaml
oc process -f $env:TEMP\mongodb.yaml `
    --param "DATABASE_SERVICE_NAME=mongo" `
    --param "MONGODB_USER=oddsalien" `
    --param "MONGODB_PASSWORD=alsofoobar" `
    --param "MONGODB_ADMIN_PASSWORD=foobar" `
    --param "MONGODB_DATABASE=alien" `
    --param "MONGODB_VERSION=3.2" | `
    oc apply -f -
```
### bash
```bash
$url = 'https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/mongodb.yaml -OutFile $env:TEMP\mongodb.yaml
curl $url/mongodb.yaml | oc process -f - \
    --param "DATABASE_SERVICE_NAME=mongo" \
    --param "MONGODB_USER=oddsalien" \
    --param "MONGODB_PASSWORD=alsofoobar" \
    --param "MONGODB_ADMIN_PASSWORD=foobar" \
    --param "MONGODB_DATABASE=alien" \
    --param "MONGODB_VERSION=3.2" | \
    oc apply -f -
```

## Configure your App
You can see the env vars expected [here](https://github.com/lucastheisen/s2i-spring-boot-kong/blob/master/s2i/bin/run).  I would like to provide a template for this, but ran out of time...
