#!/bin/bash

while read line; do
    fasterq-dump --split-files ${line}.sra
done < /scratch1/dottieyu/unmapped_samples/accessions.txt
