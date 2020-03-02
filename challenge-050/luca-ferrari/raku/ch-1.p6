#!env raku
#
# Perl Weekly Challenge 50
# see
# <https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/>
#
# Task 1
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
# [2,7], [3,9], [10,12], [15,19], [18,22]
# The script should merge [2, 7] and [3, 9]
# together to return [2, 9].
# Similarly it should also merge [15, 19]
# and [18, 22] together to return [15, 22].
# The final result should be something like below:
# [2, 9], [10, 12], [15, 22]


sub overlap( Range $a, Range $b ) {
    return $b.max > $a.max > $b.min || $b.max >  $a.min > $b.min;
}

sub merge( Range $a, Range $b ) {
    return Range.new: min( $a.min, $b.min ), max( $b.max, $a.max );
}




my @ranges = 2..7, 3..9, 10..12, 15..19, 18..22;
my @merged-ranges;

while ( @ranges.elems > 1 ) {
    if overlap( @ranges[ 0 ], @ranges[ 1 ] ) {
        # merge the ranges
        @merged-ranges.push: merge( @ranges[ 0 ], @ranges[ 1 ] );
        @ranges.shift;
        @ranges.shift;
    }
    else {
        # dont' merge, push the first one
        @merged-ranges.push: @ranges[ 0 ];
        @ranges.shift;
    }
}


@merged-ranges.say;
