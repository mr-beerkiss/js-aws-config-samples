#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

run_cfn() {
  local intent=$1
  local stack_name=$2
  local inFile=$3

  local abs_file_path=""
  abs_file_path="$(cd "$(dirname "$inFile")"; pwd)/$(basename "$inFile")"

  if [ "$intent" == 'create' ]
  then
    printf 'Creating stack %s\n' "$stack_name" 
    aws cloudformation create-stack --stack-name "$stack_name" --template-body="file://${abs_file_path}"
  elif [ "$intent" == 'update' ]
  then
    printf 'Updating stack %s\n' "$stack_name" 
    aws cloudformation update-stack --stack-name "$stack_name" --template-body="file://${abs_file_path}"
  elif [ "$intent" == 'validate' ]
  then
    printf 'Validating template %s\n' "$inFile" 
    aws cloudformation validate-template --template-body="file://${abs_file_path}"
  elif [ "$intent" == 'delete' ]
  then
    printf 'Deleting stack %s\n' "$stack_name" 
    aws cloudformation delete-stack --stack-name "$stack_name"
  else
    printf 'Unknown intent: %s\n' "$intent"
    exit 1
  fi
}


help() {
  local help_type=$1
  if [ "$help_type" == 'intent' ]
  then
    echo "Specify an intent: [create, update, delete, validate]"
  else
    echo "You must specify a type to run [config]"
  fi
}

INTENT=${1:-''}
TYPE=${2:-''}

[[ -z $INTENT ]] && help intent && exit 1
[[ -z $TYPE ]] && help type && exit 1

if [ "$TYPE" == 'config' ]
then
  printf 'Running %s Cloudformation...\n' "$TYPE"
  run_cfn "$INTENT" 'nodejs-config-demo-config' config-demo.yaml
else 
  printf 'Unknown type %s\n' "$TYPE"
  exit 1
fi




