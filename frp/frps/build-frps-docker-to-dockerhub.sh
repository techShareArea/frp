#!/usr/bin/env bash

TAG=techsharearea/frps:2020

docker build -t $TAG .

docker push $TAG      
