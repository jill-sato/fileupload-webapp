#!/bin/sh

apk add make curl bash
pip3 install -r requirements.txt

make run &
pid=${!}
sleep 2

make test

kill -9 ${pid}
