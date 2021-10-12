#!/usr/bin/env raku

# This program only deals with pandigital numbers up to 9,876,543,210 
# (or up to the 3,265,920th)

use Test;
plan 2;

subset pd-index of UInt where * < 3_265_920;

my $seq := 0, 362879, 362880, { |($^a + 362880, $^b + 362880) } ... *;

is-deeply pandigital(^5), (1023456789, 
                           1023456798, 
                           1023456879, 
                           1023456897, 
                           1023456978), 'Example 1';

is-deeply pandigital($seq[^18]), (1023456789, 1987654320, 
                                  2013456789, 2987654310, 
                                  3012456789, 3987654210,
                                  4012356789, 4987653210, 
                                  5012346789, 5987643210, 
                                  6012345789, 6987543210,
                                  7012345689, 7986543210,
                                  8012345679, 8976543210,
                                  9012345678, 9876543210), 'Edge Cases';

sub pandigital(+$arr where .all ~~ pd-index)
{
    gather 
    {
        for 1..9 -> $n
        {
            for create-list($n).permutations -> $list
            {
                last if $list[0] == 0;
                take $list;
            }
        }
    }[|$arr]>>.join>>.Int 
}

sub create-list($n)
{
    my $head = ($n, 0);
    my $tail = ^10 (-) $head;
    |$head, |$tail.keys.sort;
}   
