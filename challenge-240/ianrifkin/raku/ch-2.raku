use v6;

# You are given an array of integers.
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.

# Example 1
my @ints = (0, 2, 1, 5, 3, 4);
create_new_array(@ints);

# Example 2
@ints = (5, 0, 1, 2, 3, 4);
create_new_array(@ints);

sub create_new_array {
    my (@ints) = @_;
    my @new_ints;
    # Loop through old array to create new array
    for @ints.kv -> $index, $item {
    	@new_ints[$index] = @ints[@ints[$index]];
    }
    say( "(" ~ join(', ', @new_ints) ~ ")\n" );
}

