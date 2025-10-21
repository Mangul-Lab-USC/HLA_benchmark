#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --mem=96GB
#SBATCH --time=12:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dottieyu@usc.edu

while read line; do
    cd /scratch1/dottieyu/unmapped_samples/${line}

    samtools view -h Aligned.sortedByCoord.out.bam chr6 > extracted.sam
    samtools view -h -q 30 extracted.sam > extracted.filtered.sam
    samtools view -S -b extracted.filtered.sam > extracted.filtered.bam
    samtools fastq -@ 8 extracted.filtered.bam \
        -1 ${line}_1.fastq.gz \
        -2 ${line}_2.fastq.gz \
        -0 /dev/null \
        -s /dev/null \
        -n

    gunzip ${line}_1.fastq.gz
    gunzip ${line}_2.fastq.gz

    mv ${line}_1.fastq ../FINAL
    mv ${line}_2.fastq ../FINAL
done < /scratch1/dottieyu/unmapped_samples/accessions.txt
