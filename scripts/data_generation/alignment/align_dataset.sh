#!/bin/bash

# Usage: bash align_dataset.sh <dataset_name>
# Example: bash align_dataset.sh d2

if [ $# -eq 0 ]; then
    echo "Error: No dataset name provided"
    echo "Usage: bash align_dataset.sh <dataset_name>"
    echo "Example: bash align_dataset.sh d2"
    exit 1
fi

DATASET=$1

while read line; do
        echo "#!/bin/bash">run_${line}.sh;
        echo "#SBATCH --nodes=1">>run_${line}.sh;
        echo "#SBATCH --ntasks=1">>run_${line}.sh;
        echo "#SBATCH --cpus-per-task=12">>run_${line}.sh;
        echo "#SBATCH --mem=40GB">>run_${line}.sh;
        echo "#SBATCH --time=12:00:00">>run_${line}.sh;
        echo "STAR --runThreadN 8 --genomeDir /scratch1/rayyala/indexes/ --readFilesIn /scratch1/rayyala/${DATASET}/fasta/${line}_1.fastq /scratch1/rayyala/${DATASET}/fasta/${line}_2.fastq --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix /scratch1/rayyala/HLA_data/bams/${DATASET}/${line}">>run_${line}.sh
done</scratch1/rayyala/HLA_data/accession_lists/${DATASET}_list.txt
