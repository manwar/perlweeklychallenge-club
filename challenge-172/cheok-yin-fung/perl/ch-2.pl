#!/usr/bin/perl
# "For discrete distributions, there is no universal 
# agreement on selecting the quartile values."
# (https://en.wikipedia.org/wiki/Quartile)
#
# For method 3:
# test data of method 3 comes from https://www.wolframalpha.com
# the definition on en.wikipedia.org seems wrong
#    Thursday, July 07, 2022 AM12:34:44 HKT
#
# The Weekly Challenge 172
# Task 2 Five-number Summary
use v5.24.0;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use POSIX qw/floor/;

if (defined $ARGV[1]) {
    for my $i (1..4) {
        say " ", join ", ", map {sprintf "%.2f", $_ } fns([@ARGV], $i)->@*;
    }
}



sub _median {     # expect @arr is sorted
    my @arr = @_;
    my $s = scalar @arr;
    return $s % 2 == 0
              ? ($arr[$s/2-1] + $arr[$s/2])/2
              : $arr[($s-1)/2];
}



sub fns ($inp , $quartile_method = 1) {
# (definition of the methods follows en.wikipedia.org/wiki/Quartile)
    my @arr = $inp->@*;
    @arr = sort {$a<=>$b} @arr;
    my $s = scalar @arr;
    if ($quartile_method == 2 && $s % 2 == 1) {
        return [$arr[0],
                _median(@arr[0..($s-1)/2]),
                $arr[($s-1)/2],
                _median(@arr[($s-1)/2..$s-1]),
                $arr[-1]];
    }
    if ( ($quartile_method == 2 || $quartile_method == 1) && $s % 2 == 0) {
        return [$arr[0],
                _median(@arr[0..$s/2-1]),
                _median(@arr),
                _median(@arr[$s/2..$s-1]),
                $arr[-1]];
    }
    if ( $quartile_method == 1 && $s % 2 == 1) {
        return [$arr[0],
                _median(@arr[0..($s-3)/2]),
                $arr[($s-1)/2],
                _median(@arr[($s+1)/2..$s-1]),
                $arr[-1]]; 
    }
    if ( $quartile_method == 3 ) {
        return fns([@arr], 1) if $s % 2 == 0;
        my $m = _median(@arr);
        my $f = scalar @arr / 4;
        if (scalar @arr % 4 == 1) {
            return [$arr[0],
                    $arr[$f-1]/4 + $arr[$f]*3/4,
                    $m,
                    $arr[3*$f]*3/4 + $arr[3*$f+1]/4,
                    $arr[-1]];
        }
        else {     # scalar @arr % 4 == 3
            return [$arr[0],
                    $arr[$f]*3/4 + $arr[$f+1]/4,
                    $m,
                    $arr[3*$f-1]/4 + $arr[3*$f]*3/4,
                    $arr[-1]]; 
        }
    }
    if ( $quartile_method == 4 ) {
        my $k1 = floor(($s+1)/4);
        my $k3 = floor(($s+1)*3/4);
        my $a1 = ($s+1)/4 - $k1;
        my $a3 = ($s+1)*3/4 - $k3;
        return [$arr[0],
                $arr[$k1-1]+$a1*($arr[$k1]-$arr[$k1-1]),
                _median(@arr),
                $arr[$k3-1]+$a3*($arr[$k3]-$arr[$k3-1]),
                $arr[-1]];
    }

    # if the quartile method parameter is set incorrectly
    return fns([@arr], 1);  
}



use Test::More tests => 13;
use Test::Deep;
cmp_deeply fns([1,3],1), [1, 1, 2, 3, 3];
cmp_deeply fns([1,2,3],1), [1, 1, 2, 3, 3];
cmp_deeply fns([6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49], 1),
           [6, 15, 40, 43, 49];
cmp_deeply fns([7, 15, 36, 39, 40, 41], 1),
           [7, 15, 37.5, 40, 41];
cmp_deeply fns([1,3],2), [1, 1, 2, 3, 3];
cmp_deeply fns([1,2,3],2), [1, 1.5, 2, 2.5, 3];
cmp_deeply fns([6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49], 2),
           [6, 25.5, 40, 42.5, 49];
cmp_deeply fns([7, 15, 36, 39, 40, 41], 2),
           [7, 15, 37.5, 40, 41];
cmp_deeply fns([7, 15, 36, 39, 40, 41], 3),
           [7, 15, 37.5, 40, 41];
cmp_deeply fns([7, 15, 36, 39, 40, 41, 42, 43, 47], 3),  # $s == 9
           [7, 30.75, 40, 42.25, 47];
cmp_deeply fns([6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49], 3),  # $s == 11
           [6, 20.25, 40, 42.75, 49];
cmp_deeply fns([6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49], 4),
            [6, 15, 40, 43, 49];
cmp_deeply fns([7, 15, 36, 39, 40, 41], 4), 
            [7, 13, 37.5, 40.25, 41];
