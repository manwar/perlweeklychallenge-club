sub unique_occurrences(@ints) {
    my %count;

    # Count occurrences of each value in the array
    for @ints -> $num {
        %count{$num}++;
    }

    # Check if the number of occurrences is unique
    my %occurrences_count;
    for %count.values -> $value {
        %occurrences_count{$value}++;
    }

    # Return 1 if all occurrences are unique, 0 otherwise
    return %occurrences_count.keys == %count.values.elems ?? 1 !! 0;
}

# Example 1
my @ints1 = (1,2,2,1,1,3);
say "Example 1: ", unique_occurrences(@ints1);

# Example 2
my @ints2 = (1,2,3);
say "Example 2: ", unique_occurrences(@ints2);

# Example 3
my @ints3 = (-2,0,1,-2,1,1,0,1,-2,9);
say "Example 3: ", unique_occurrences(@ints3);
