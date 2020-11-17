#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku - 086
# Task: Pair Difference 

use strict;
use warnings;
# use Test::More tests => 3;

pair_diff(@ARGV) if $ARGV[0];

sub pair_diff {

    my $dff = shift @_;
    my @arr = sort {$a <=> $b} @_;



    if ($dff < 0) {
        $dff = -$dff;
    }

    my @newarr = map { $arr[$_+1] - $arr[$_] } (0..$#arr-1);


    my $bool = 1;
    for my $e (@newarr) {
        $bool = $bool && $dff < $e;
        if ($dff == $e) {
            print 1,"\n";
            return 1;
        }
    }

    if ($bool) {
        print "The difference required may be too small.\n"; 
        print 0,"\n"; 
        return 0;
    }

    for my $i (0..$#arr-1) {
        for my $j ($i+1..$#arr) {
            if ($dff == $arr[$j]-$arr[$i]) {
                print 1,"\n";
                return 1;
            }
        }
    }

    print 0,"\n";
    return 0;

}


=pod
ok pair_diff(7, 10, 8, 12, 15, 5) == 1, "example 1";
ok pair_diff(6, 1, 5, 2, 9, 7) == 1, "example 2";
ok pair_diff(15, 10, 30, 20, 50, 40) == 0, "example 3";
=cut
