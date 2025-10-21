#!/bin/bash

while read line; do
    cd /scratch1/dottieyu/unmapped_samples/${line}
    samtools index Aligned.sortedByCoord.out.bam
done < /scratch1/dottieyu/unmapped_samples/accessions.txt
