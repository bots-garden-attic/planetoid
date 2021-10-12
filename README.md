# Planetoid

**Planetoid** is a small piece of JavaScript code to serve a Rust Wasm function

[![Open in GitPod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/bots-garden/planetoid)

## Create a function

### First, generate a skeleton function

```bash
cd src
./create-function.sh myfunction
```

### Update the source code

Look at `./src/myfunction/src/lib.rs`

### Build the function

```bash
cd src
./build-function.sh myfunction
```

### "deploy" the function

> aka: copy it to `./functions`

```bash
cd src
./deploy-function.sh myfunction 0.0.0
# 0.0.0 is the function version
```

## Launch Planetoid

```bash
node planetoid.js <function name> <function version>
# example: node planetoid.js myfunction 0.0.0  
```

- 🖐️ the functions must be in the `./functions` directory
- 🖐️ a function is named like this: `<function name>_v_<function version>.wasm`

## Call the function

```bash
# With HTTPie
http POST http://localhost:8080 name=bob rwaapi_data:"hello world" rwaapi_token:"tada"

# With curl
url_api=http://0.0.0.0:8080
data='{"name":"Bob Morane"}'
curl -d "${data}" \
      -H "Content-Type: application/json" \
      -H "rwaapi_data: 'hello world'" \
      -H "rwaapi_token: 'tada'" \
      -X POST "${url_api}"
```

> 🖐️ **Remark**:
> - you can use default headers:
>   - `rwaapi_data` (the default value is an empty string)
>   - `rwaapi_token` (the default value is an empty string)
>   - `rwaapi_function_name` (the default value is the function name)
>   - `rwaapi_function_version` (the default value is the function version)

## Load testing

I used [Hey](https://github.com/rakyll/hey)

```bash
url_api="http://localhost:8080"
data='{"name":"Bob"}'

hey -n 10000 -c 1000 -m POST -T "Content-Type: application/json" -H "rwaapi_token:tada" -H "rwaapi_data:hello world" -d ${data} "${url_api}" 
```

> Results:
```bash
Summary:
  Total:        2.6655 secs
  Slowest:      2.2152 secs
  Fastest:      0.0008 secs
  Average:      0.2176 secs
  Requests/sec: 3751.6491
  

Response time histogram:
  0.001 [1]     |
  0.222 [7649]  |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  0.444 [1003]  |■■■■■
  0.665 [374]   |■■
  0.887 [247]   |■
  1.108 [396]   |■■
  1.329 [261]   |■
  1.551 [5]     |
  1.772 [21]    |
  1.994 [0]     |
  2.215 [43]    |


Latency distribution:
  10% in 0.0316 secs
  25% in 0.0671 secs
  50% in 0.1023 secs
  75% in 0.2091 secs
  90% in 0.6582 secs
  95% in 0.9616 secs
  99% in 1.2300 secs

Details (average, fastest, slowest):
  DNS+dialup:   0.0292 secs, 0.0008 secs, 2.2152 secs
  DNS-lookup:   0.0314 secs, 0.0000 secs, 0.2692 secs
  req write:    0.0000 secs, 0.0000 secs, 0.0063 secs
  resp wait:    0.1439 secs, 0.0007 secs, 1.9148 secs
  resp read:    0.0092 secs, 0.0000 secs, 0.4558 secs

Status code distribution:
  [200] 10000 responses
```

## Btw

If you need a web server to serve several functions, 👀 have a look to https://github.com/bots-garden/rwaapi
