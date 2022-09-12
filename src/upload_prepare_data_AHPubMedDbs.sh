#!/bin/bash

METADATA_VERSION=$1
OUTPUT=$2

mkdir -p Azure/AHPubMedDbs/${METADATA_VERSION}
cp -rf sqlite/*  Azure/AHPubMedDbs/${METADATA_VERSION}/
echo "" > ${OUTPUT}
