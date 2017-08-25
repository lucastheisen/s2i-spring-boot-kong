# Spring Boot behind Kong


## Install this Builder
```powershell
$url = 'https://raw.githubusercontent.com/lucastheisen/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/sti.yaml -OutFile $env:TEMP\sti.yaml
oc create -f $env:TEMP\sti.yaml
```

## Install Kong
```powershell
$url = 'https://raw.githubusercontent.com/lucastheisen/s2i-spring-boot-kong/master'
Invoke-WebRequest $url/kong.yaml -OutFile $env:TEMP\kong.yaml
oc process -f $env:TEMP\kong.yaml --param APP_NAMESPACE=$(oc project -q) | `
    oc apply -f -
```

## Configure your App
You can see the env vars expected [here](https://github.com/lucastheisen/s2i-spring-boot-kong/blob/master/s2i/bin/run).  I would like to provide a template for this, but ran out of time...