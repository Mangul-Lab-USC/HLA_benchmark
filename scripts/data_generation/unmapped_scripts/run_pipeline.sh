#!/bin/bash

set -e

echo "Starting unmapped RNA-seq processing pipeline..."

echo "Step 1: Converting SRA to FASTQ..."
bash sra_to_fq_1.sh

echo "Step 2: Aligning samples with STAR..."
sbatch align_samples_2.sh
echo "Waiting for alignment jobs to complete..."
echo "Check job status with: squeue -u $USER"
read -p "Press Enter when alignment jobs are finished..."

echo "Step 3: Indexing BAM files..."
bash bam_to_bai_3.sh

echo "Step 4: Filtering and extracting reads..."
sbatch filter_and_extract_4.sh
echo "Waiting for filter jobs to complete..."
echo "Check job status with: squeue -u $USER"
read -p "Press Enter when filter jobs are finished..."

echo "Step 5: Concatenating mapped and unmapped reads..."
bash concat_mapped_unmapped.sh

echo "Pipeline complete!"
