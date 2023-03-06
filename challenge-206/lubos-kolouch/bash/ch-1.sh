#!/bin/bash

# Declare an array of time points
time=("$@")

# Declare an array of minutes
minutes=()

# Loop over the time points and convert them to minutes
for t in "${time[@]}"; do
  # Split the time point by colon
  IFS=":" read -r h m <<< "$t"
  # Calculate the minutes using base 10 arithmetic
  ((m = 10#$h * 60 + 10#$m))
  # Append the minutes to the array
  minutes+=("$m")
done

# Sort the minutes array numerically
sorted=($(printf '%s\n' "${minutes[@]}" | sort -n))

# Declare a variable for minimum difference and initialize it with a large value
min_diff=1440

# Loop over the sorted array and find the minimum difference between any two adjacent elements
for ((i = 0; i < ${#sorted[@]}; i++)); do
  # Get the next index modulo the array length
  ((j = (i + 1) % ${#sorted[@]}))
  # Calculate the absolute difference between current and next element
  ((diff = ${sorted[j]} - ${sorted[i]}))
  # Make sure the difference is positive
  ((diff = diff < 0 ? -diff : diff))
  # If the difference is larger than half a day, subtract it from a full day
  ((diff = diff > 720 ? 1440 - diff : diff))
  # Update the minimum difference if needed
  ((min_diff = min_diff < diff ? min_diff : diff))
done

# Print the output in minutes format
echo "$min_diff"
