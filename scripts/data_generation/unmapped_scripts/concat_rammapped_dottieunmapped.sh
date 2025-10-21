#!/bin/bash

while read line; do
    cd /scratch1/dottieyu/unmapped_samples/${line}

    cat Unmapped.out.mate1 /scratch1/rayyala/HLA_data/d1/${line}Aligned.sortedByCoord.out.extracted.1.fq >> ${line}.ramdottiecombined.1.fq
    cat Unmapped.out.mate2 /scratch1/rayyala/HLA_data/d1/${line}Aligned.sortedByCoord.out.extracted.2.fq >> ${line}.ramdottiecombined.2.fq

    mv *.ramdottiecombined.*.fq ../FINAL
done < /scratch1/dottieyu/unmapped_samples/accessions.txt
