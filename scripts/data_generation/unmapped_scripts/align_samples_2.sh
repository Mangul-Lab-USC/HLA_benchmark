#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --mem=128GB
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dottieyu@usc.edu

while read line; do
    mkdir /scratch1/dottieyu/unmapped_samples/${line}
    cd /scratch1/dottieyu/unmapped_samples/${line}
    STAR --genomeDir /scratch1/dottieyu/gencode_GRCh38-p14/genomedir \
         --readFilesIn /scratch1/dottieyu/unmapped_samples/raw_fq/${line}_1.fastq \
                       /scratch1/dottieyu/unmapped_samples/raw_fq/${line}_2.fastq \
         --outSAMtype BAM SortedByCoordinate \
         --outReadsUnmapped Fastx
done < /scratch1/dottieyu/unmapped_samples/accessions.txt
