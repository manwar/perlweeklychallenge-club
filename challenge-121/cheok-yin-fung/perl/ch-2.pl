#!/usr/bin/perl
# The Weekly Challenge - 121
# Task 2 The Travelling Salesman
# a brute-force solution via permutations again
# Usage: $ ch-2.pl
use strict;
use warnings;
use Algorithm::Combinatorics qw/permutations/;
use feature qw/say/;

my $M;

my $M04 = [
    [0, 5, 2, 7],
    [5, 0, 5, 3],
    [3, 1, 0, 6],
    [4, 5, 4, 0]
];

my $M09 = [
    [0,2,3,9,4,1,8,5,2],
    [8,0,6,4,6,5,2,8,8],
    [8,4,0,9,4,9,6,8,9],
    [3,4,5,0,5,8,6,3,1],
    [1,4,2,5,0,4,7,2,9],
    [5,8,8,9,1,0,7,7,1],
    [4,5,8,2,5,3,0,9,2],
    [6,6,1,7,9,6,9,0,8],
    [3,1,4,3,9,7,3,3,0]
];

my $M15 = [
[ 0 , 1 , 3 ,11 , 9 ,13 , 2 ,15 ,10 ,10 ,13 , 9 , 3 ,15 , 8],
[15 , 0 , 7 ,13 , 6 , 3 , 7 , 7 , 3 , 6 , 1 , 1 ,11 , 2 ,12],
[ 9 , 7 , 0 ,16 , 5 ,14 ,12 , 2 , 6 ,16 ,10 , 9 , 8 ,13 , 3],
[ 1 , 4 , 5 , 0 , 9 ,14 , 3 ,10 , 2 ,11 , 4 ,12 , 5 , 9 , 7],
[11 , 2 , 8 , 8 , 0 , 8 ,16 , 1 , 1 , 7 , 6 , 8 ,15 , 4 , 3],
[ 1 , 4 , 8 ,13 , 7 , 0 ,13 ,13 , 6 , 4 ,12 , 5 , 1 , 7 , 9],
[ 6 , 8 , 6 ,13 , 3 ,11 , 0 , 7 , 1 ,14 , 2 ,12 , 1 , 7 , 5],
[ 2 ,12 , 2 ,11 ,14 ,13 , 2 , 0 , 8 , 7 , 2 , 2 , 2 , 9 , 2],
[14 ,14 ,15 , 8 ,16 , 5 ,14 ,15 , 0 , 9 ,14 , 3 ,11 , 3 ,13],
[11 , 8 , 2 ,12 ,12 , 1 ,11 ,11 , 2 , 0 , 3 , 4 , 2 ,10 , 5],
[12 , 4 , 2 , 8 , 6 ,10 , 7 ,15 ,16 , 4 , 0 ,12 , 1 , 5 ,10],
[13 ,13 , 7 , 8 ,16 ,10 , 9 ,14 , 9 ,11 , 6 , 0 , 8 ,10 , 6],
[15 ,14 , 4 ,15 , 5 ,16 ,14 , 6 , 4 ,16 , 4 , 3 , 0 , 2 , 2],
[ 2 , 2 , 9 ,12 , 8 , 8 ,13 ,15 , 1 , 5 ,16 , 1 , 1 , 0 ,12],
[14 , 6 ,14 , 6 , 9 , 1 ,11 ,12 ,11 , 5 , 9 , 9 , 6 , 4 , 0]
];

# $M09 and $M15 are produced by:
# https://onlinemathtools.com/generate-random-matrix
# manually edit the diagonal afterwards 
# (but they won't be referenced actually)

$M = $M09;
my $N = $ARGV[0] || scalar @{$M};

# $M = $M04, $N = 4 (Task Example)
# length = 10
# tour = (0 2 1 3 0)

# $M = $M15, $N = 11
# length = 30
# tour = (0 1 5 9 10 2 7 6 4 8 3)

# $M = $M15, $N = 12
# length = 33
# tour = (0 1 5 9 10 2 7 6 4 8 11 3 0)

my $min = 10000;
my @arr_min = ();

my $v = chr(ord("A")+$N-2);
my $iter = permutations(['A'..$v]);
while (my $c = $iter->next) {
    my $d = calc_dist($c);
    if (defined($d) && $d <= $min) {  #related to the improvement A
        if ($d < $min) {
            @arr_min = ();
            $min = $d;
            say "new shorter circuit found: @{$c}"; #facilitate testing
        }
        push @arr_min, $c;
    }
}

say "";
say "length = $min";
say ('tour = (0 ', (join " ", map {alp2n($_)} @{$arr_min[0]}) , ' 0)' ) ;


sub alp2n {
    return ord($_[0])-ord("A")+1;
}


sub calc_dist {
    my @seq = @{$_[0]};
    my $dist = 0;
    $dist += $M->[0][ alp2n($seq[0]) ];
    for my $i (0..$#seq-1) {
        $dist += $M->[ alp2n($seq[$i]) ][ alp2n($seq[$i+1]) ];
        return undef if $dist >= $min;    # a slightly improvement A 
    }
    $dist += $M->[alp2n($seq[-1])][0];
}

