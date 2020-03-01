#!/usr/bin/env bash

TAG=cr.cjkj.co/caiji/frps:2020

docker build -t $TAG .

docker push $TAG
