# Planetoid

**Planetoid** is a small piece of JavaScript code to serve a Rust Wasm function

[![Open in GitPod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/bots-garden/planetoid)

## Launch Planetoid

```bash
node planetoid.js <function name> <function version>
# example: node planetoid.js hello 0.0.0  
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


## Btw

If you need a web server to serve several functions, 👀 have a look to https://github.com/bots-garden/rwaapi
