#!env raku




# Write a script that accepts list of positive numbers (@L) and two positive numbers $X and $Y.
# 
# The script should print all possible numbers made by concatenating
# the numbers from @L, whose length is exactly $X
# but value is less than $Y.
#     Example
# 
#   Input:
# 
#     @L = (0, 1, 2, 5);
# $X = 2;
# $Y = 21;
# 
#  Output:
# 
#     10, 11, 12, 15, 20



sub MAIN ( ){
    my @L = (0, 1, 2, 5);
    my $x = 2;
    my $y = 21;
    my @LL;

    # start from the very beginning of the list limiting
    # the numbers in the range of $y
    for ( 1 x $x ) - 1 ..^ $y {

        # see if the numbers "grep" the list
        my $found = 0;
        $found++ if $_ == any( @L ) for $_.comb;
        @LL.push: $_ if $_.comb.elems == $found;
    }

    say @LL.join( ', ' );
}
