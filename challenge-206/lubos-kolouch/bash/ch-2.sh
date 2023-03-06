#!/bin/bash

# Function to find the maximum sum of the minimum of each pairs
max_sum_min_pairs() {
  # Get the array as an argument
  local array=("$@")
  # Sort the array in ascending order
  local sorted_array=($(printf "%s\n" "${array[@]}" | sort -n))
  # Initialize the sum variable
  local sum=0
  # Loop through the array with a step of 2
  for ((i=0; i<${#sorted_array[@]}; i+=2)); do
    # Add the minimum of each pair to the sum
    sum=$((sum + sorted_array[i]))
  done
  # Return the sum
  echo $sum
}

# Read the input array from standard input or command line arguments
if [ -z "$1" ]; then
  read -a input_array
else
  input_array=("$@")
fi

# Check if the input array has even number of elements
if [ $((${#input_array[@]} % 2)) -ne 0 ]; then
  echo "Error: The input array must have even number of elements."
else 
  # Call the function and print the output 
  output=$(max_sum_min_pairs "${input_array[@]}")
  echo "Output: $output"
fi

