#!/bin/bash

while read line; do
    cd /scratch1/dottieyu/unmapped_samples/${line}

    cat Unmapped.out.mate1 ${line}_1.fastq >> ${line}.combined.1.fq
    cat Unmapped.out.mate2 ${line}_2.fastq >> ${line}.combined.2.fq

    mv *.combined.*.fq ../FINAL
done < /scratch1/dottieyu/unmapped_samples/accessions.txt
