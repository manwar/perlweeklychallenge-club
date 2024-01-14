# The Weekly Challenge 251
# Task 1 Concatenation Value
use v5.30.0;
use warnings;
use List::Util qw/sum/;
use List::MoreUtils qw/pairwise/;

sub cv {
    my @ints = @_;
    my $mid = @ints % 2 ? (splice @ints, @ints / 2, 1) : 0;
    my @rints = reverse @ints;
    @ints = @ints[0..@ints/2-1];
    @rints = @rints[0..@rints/2-1];
    my $ans = $mid + (sum(pairwise {$a.$b} @ints, @rints));
    return $ans;
}

use Test2::V0;
is cv(6,12,25,1),1286;
is cv(10,7,31,5,2,2),489;
is cv(1,2,10),112;

done_testing;
