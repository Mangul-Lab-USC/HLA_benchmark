#!/bin/bash

# Output file name
output="hlapers_zymo.csv"  # Replace with your desired output file name

# Check if the output file exists and delete it if it does
if [ -e "${output}" ]; then
  rm "${output}"
  echo "Deleted existing ${output}"
else
  echo "${output} does not exist, creating new file."
fi

# Initialize the output file with the header
echo ",A,A.1,B,B.1,C,C.1,DQB1,DQB1.1,DRB1,DRB1.1" > "${output}"

# Loop through all TSV files in the current directory
for input_file in *.tsv; do 
    # Extract the middle term from the file name to use as a new column value
    name=$(echo "${input_file}" | awk -F'_' '{print $2}')
    
    # Clear the associative array to store the top 2 alleles for each locus for the new sample
    declare -A alleles=()

    # Process the input file to filter, sort, and select alleles
    selected_alleles=$(awk -F'\t' '$1 == "A" || $1 == "B" || $1 == "C" || $1 == "DRB1" || $1 == "DQB1"' "${input_file}" |
    sort -k1,1 -k3,3nr | 
    awk -F'\t' '{
        if ($1 != prev) { count = 0; prev = $1 }
        if (count < 2) { print; count++ }
        }' |
    sed 's/-/\//g')

    # Read the selected alleles and store them in the associative array
    while IFS=$'\t' read -r locus allele _; do
        if [ -n "$allele" ]; then
            # Append alleles to the corresponding locus type
            if [ -z "${alleles[$locus]}" ]; then
                alleles[$locus]="$allele"
            else
                alleles[$locus]="${alleles[$locus]},$allele"
            fi
        fi
    done <<< "$selected_alleles"

    # Generate a row in the CSV file for the current sample
    echo "$name,${alleles[A]},,${alleles[B]},,${alleles[C]},,${alleles[DQB1]},,${alleles[DRB1]}," >> "${output}"

    echo "Processed ${input_file}"
done

echo "All files have been combined and processed into ${output}."

