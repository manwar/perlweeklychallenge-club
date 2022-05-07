#!/usr/bin/env perl
#
# ch-1.pl - Bitwise Sum
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use List::Util qw< sum >;


say sum_bitwise(@ARGV);


sub sum_bitwise {
    sum map {
        my $i = $_;
        map {
            $_[$i] & $_[$_] 
        } $i+1..$#_ 
    } 0..$#_
}
