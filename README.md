# Spring Boot behind Kong


## Install this Builder
### powershell
```powershell
$url = 'https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/s2i-spring-boot-kong.yaml -OutFile $env:TEMP\s2i-spring-boot-kong.yaml
oc create -f $env:TEMP\s2i-spring-boot-kong.yaml
```
### bash
```bash
url='https://raw.githubusercontent.com/kevinbloomfield/s2i-spring-boot-kong/master'
curl $url/s2i-spring-boot-kong.yaml | oc create -f -
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
First go add a route for kong.  We could probably add this to the template above, but we dont have https yet.  Then you need to add a secret for your git creds.  Finally, use the `s2i-spring-builder-kong` _template_ to add a microservice...