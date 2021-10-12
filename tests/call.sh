#!/bin/bash

url_api=$(gp url 8080)
data='from Bob Morane'

http POST $(gp url 8080) name="${data}" rwaapi_data:"hello world" rwaapi_token:"tada"
