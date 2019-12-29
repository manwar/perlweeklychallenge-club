# Sort SubList
#
# You are given a list of numbers and set of indices belong to the list. Write
# a script to sort the values belongs to the indices.
#
# For example,
# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
#
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
#
# Final List would look like below:
# List: [ 1, 4, 3, 8, 12, 10 ]

sub subsort(@arr, @ind) {
    @arr[@ind] = @arr[@ind].sort; @arr;
}

say subsort([10, 4, 1, 8, 12, 3], [0, 2, 5]);
