#!/usr/bin/env bash

TAG=cr.cjkj.co/caiji/frpc:2020

docker build -t $TAG .

docker push $TAG
