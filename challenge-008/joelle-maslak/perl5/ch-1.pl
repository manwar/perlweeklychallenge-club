#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw(sum uniqnum);

if ( @ARGV > 1 )      { die("Please provide number of perfect numbers to generate") }
my $MAX = $ARGV[0] // 5;

if ($MAX > 7) {
    say "More than 7 perfect numbers may take too long to calculate";
}

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#

my @result;
while (@result < $MAX) {
    state $p = 1;
    $p++;

    my $possible = (2**($p-1))*((2**$p)-1);
    my (@factors) = factors($possible);
    pop @factors; # Remove self as factor

    if (sum(@factors) == $possible) { push @result, $possible }
}

say "(" . join(" ", @result) . ")";


sub factors($i) {
    if ($i == 0) { my (@zero) = (0); return @zero; }
    my $sqrt = int(sqrt($i));
    
    return  uniqnum
            sort { $a <=> $b }
            map  { $_, ($i / $_) }
            grep { ($i % $_) == 0 }
            1..$sqrt;
}
    
