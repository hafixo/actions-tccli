#!/bin/bash

set -e

if [ -z "$INPUT_ARGS" ]; then
  echo '::error::Required Args parameter'
  exit 1
fi

if [ -z "$INPUT_SECRET_ID" ]; then
  echo '::error::Required SecretId parameter'
  exit 1
fi

if [ -z "$INPUT_SECRET_KEY" ]; then
  echo '::error::Required SecretKey parameter'
  exit 1
fi

if [ -z "$INPUT_REGION" ]; then
  echo '::error::Required Region parameter'
  exit 1
fi

if [ -z "$INPUT_OUTPUT" ]; then
  echo 'output format: json'
fi

tccli configure set secretId $INPUT_SECRET_ID secretKey $INPUT_SECRET_KEY region $INPUT_REGION output $INPUT_OUTPUT

IFS="&&"
arrARGS=($INPUT_ARGS)

for each in ${arrARGS[@]}
do
  unset IFS
  each=$(echo ${each} | xargs)
  if [ -n "$each" ]; then
  echo "Running command: tccli ${each}"
  tccli $each
  fi
done

echo "Commands ran successfully"
