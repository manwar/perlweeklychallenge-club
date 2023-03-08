#!/bin/bash

# Read the input citations from command line arguments
citations=( "$@" )

# Function to compute the H-Index for a given array of citations
function compute_h_index {
    # Sort the array of citations in descending order
    sorted_citations=( $(echo "${citations[@]}" | tr ' ' '\n' | sort -rn) )
    # Loop through the sorted array and find the largest number h such that h articles have at least h citations each
    h_index=0
    for i in "${!sorted_citations[@]}"; do
        if (( sorted_citations[i] >= i+1 )); then
            h_index=$(( i+1 ))
        else
            break
        fi
    done
    echo "$h_index"
}

# Compute the H-Index for the input citations
compute_h_index "${citations[@]}"

