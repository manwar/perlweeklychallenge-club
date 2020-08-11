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


my @ranges = 2..7, 3..9, 10..12, 15..19, 18..22;
my @merged-ranges;

while ( @ranges.elems  ) {
    my $a = @ranges.shift;
    my $b = @ranges[ 0 ];
    @merged-ranges.push( Range.new( min( $a.min, $b.min ), max( $a.max, $b.max ) ) )
    && @ranges.shift
    && next
    if $b.max > $a.max > $b.min || $b.max >  $a.min > $b.min;

    @merged-ranges.push: $a;
}


@merged-ranges.say;
