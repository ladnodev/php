#!/usr/bin/env bash

arg=$*
su - www-data -s /bin/bash -c "/app/yii ${arg}"
