# TASK #2
# Sort SubList
# You are given a list of numbers and set of indices belong to the list. Write a script to sort the values belongs to the indices.
# 
# For example,
# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
# 
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
# 
# Final List would look like below:
#   List: [ 1, 4, 3, 8, 12, 10 ]

arr <- c(10, 4, 1, 8, 12, 3)
idx <- c(0, 2, 5)
idx <- idx + 1 # While this is R.
arr_sorted <- arr
arr_sorted[idx] <- sort(arr_sorted[idx]) # Choroba in his blog!
arr
arr_sorted