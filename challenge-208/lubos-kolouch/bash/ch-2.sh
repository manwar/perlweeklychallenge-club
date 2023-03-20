#!/bin/bash

# Define the input array
nums=(1 2 2 4)

# Find the duplicate and missing integers
n=${#nums[@]}
missing=0
duplicate=0
for (( i=0; i<n; i++ )); do
  index=${nums[i]#-}
  if (( nums[index-1] > 0 )); then
    nums[index-1]=-${nums[index-1]}
  else
    duplicate=$index
  fi
done
for (( i=0; i<n; i++ )); do
  if (( nums[i] > 0 )); then
    missing=$((i+1))
  fi
done

# Print the results
if (( missing != 0 && duplicate != 0 )); then
  echo "Duplicate is $duplicate and missing is $missing."
else
  echo "-1"
fi

