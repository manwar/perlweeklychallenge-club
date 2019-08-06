#!/usr/bin/perl6
use v6;

# 20.2
# Write a script to print the smallest pair of Amicable Numbers. https://en.wikipedia.org/wiki/Amicable_numbers

# store sums of proper divisors in a hash to aid finding its amicable pair
my %spd;
my $i=1;

loop {
    %spd{$i}=sumProperDivisors($i);

    # if an amicable pair does not exist in the hash yet, keep filling hash up
    if not %spd{%spd{$i}}:exists {
        $i++ ;
        next
    };

    # if hash has a pair, check it is amicable, and not just a perfect number
    if %spd{%spd{$i}}==$i and %spd{$i} != $i {
        say "($i," ~ %spd{$i} ~ ")";
        last
    };
    # keep going...
    $i++;
}


sub sumProperDivisors ($i) {
    return [+] (1..^$i).grep:  $i %% *  ;
}
