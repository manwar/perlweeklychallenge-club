#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku - 087
# Task: Longest Consecutive Sequence
# Usage: ch-1.pl @N

use strict;
use warnings;
use Test::More tests => 3;
use Test::Deep;

sub long_consec{
    my @list = sort {$a<=>$b} @_;
    my $max_len = 1;
    my @max_opp;

    my @potential_max_opp = ($list[0]);
    for (1..$#list) { 
        if ($list[$_-1] == $list[$_]-1) {
            push @potential_max_opp, $list[$_];
        } else
        {
            if (scalar @potential_max_opp > $max_len) {
                $max_len = scalar @potential_max_opp;
                @max_opp = @potential_max_opp;
            }
            @potential_max_opp = ($list[$_]);
        }
    }

    return \@max_opp;
}

my @temp_arr;

if ($ARGV[0]) {
    @temp_arr = @{long_consec(@ARGV)};
}
if (@temp_arr) {
    print "("; 
    print join ", ", @temp_arr;
    print ")";
} else
{
    print 0;
}

print "\n";

cmp_deeply ( long_consec(100, 4, 50, 3, 2) , [2, 3, 4], "example 1");
cmp_deeply( long_consec(10, 30, 20, 50, 40) , [], "example 2");
cmp_deeply( long_consec(20, 19, 9, 11, 10) , [9,10,11], "example 3");
