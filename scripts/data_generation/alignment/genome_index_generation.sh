#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50GB
#SBATCH --time=10:00:00
STAR --runThreadN 8 --runMode genomeGenerate --genomeDir indexes/ --genomeFastaFiles references/GRCh38.primary_assembly.genome.fa --sjdbGTFfile references/gencode.v34.annotation.gtf --sjdbOverhang 50 --outFileNamePrefix chr
