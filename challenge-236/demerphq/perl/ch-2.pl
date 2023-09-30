use strict;
use warnings;

# You are given an array of unique integers.
#
# Write a script to determine how many loops are in the given array.
#
# To determine a loop: Start at an index and take the number at
# array[index] and then proceed to that index and continue this until
# you end up at the starting index.

sub compute_index_loops {
    my ($array) = @_;

    # This implementation is deterministic, and is fast. It looks like
    # it could scan @$array one less time than it contains loops,
    # whereas an implementation using a hash might avoid this exact
    # scan, but in practice it is about twice as fast as a hash based
    # implementation. Yes this suprised me! For one thing, if the
    # indexes are fairly shuffled then on average it will only have to
    # inspect 1/2 of the indexes it contains. For another, looping over
    # a few thousand elements is fast, so unless the array is very large
    # and there are a huge number of loops this code is reasonably fast.

    my @seen;
    my @loops = [];
    my $this = 0;
    my $count = 0;
    do {
        while (!$seen[$this]++) {
            $count++; # for sanity checking.
            push @{$loops[-1]}, $this;
            $this = $array->[$this];
        }
        $this = undef;
        for my $i (0 .. $#$array) {
            if (!$seen[$i]) {
                $this = $i;
                push @loops,[];
                last;
            }
        }
    } while defined $this;
    if ($count != @$array) {
        die "Duplicate index in array ($count,", 0+@$array,")\n";
    }
    pop @loops unless @{$loops[-1]};
    return \@loops;
}

sub count_loops {
    my $loops = compute_index_loops(@_);
    return 0+@$loops;
}

use Test::More;
foreach my $tuple (
    [3,[(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)]],
    [6,[(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)]],
    [1,[(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)]],
){
    my ($want, $array) = @$tuple;
    my $loops = compute_index_loops($array);
    if ($ENV{VERBOSE}) {
        print "Input: @$array\n";
        printf "  %2d: %s\n", $_+1, join ", ", @{$loops->[$_]} for 0..$#$loops;
    }
    is(0+@$loops,$want,"Want $want from @$array");
}
done_testing;
