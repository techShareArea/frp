#!/usr/bin/env bash

TAG=techsharearea/frpc:2020

docker build -t $TAG .

docker push $TAG
