use v5.36;
use strict;
use warnings;
##
# You are given list of integers @list of size $n and divisor $k.
# Write a script to find out count of pairs in the given list that satisfies the following rules.
# The pair (i, j) is eligible if and only if
#    a) 0 <= i < j < len(list)
#    b) list[i] + list[j] is divisible by k
##

sub divisible_pairs{
    my($numbers, $k) = @_;
    my @pairs;
    for my $i (0 .. @{$numbers} - 1){
        for my $j ($i + 1 .. @{$numbers} - 1){
            push @pairs, [$i, $j] if(($numbers->[$i] + $numbers->[$j]) % $k == 0);
        }
    }
    return @pairs;
}

MAIN:{
    my @pairs;
    @pairs = divisible_pairs([4, 5, 1, 6], 2);
    print @pairs . "\n";
    @pairs = divisible_pairs([1, 2, 3, 4], 2);
    print @pairs . "\n";
    @pairs = divisible_pairs([1, 3, 4, 5], 3);
    print @pairs . "\n";
    @pairs = divisible_pairs([5, 1, 2, 3], 4);
    print @pairs . "\n";
    @pairs = divisible_pairs([7, 2, 4, 5], 4);
    print @pairs . "\n";
}