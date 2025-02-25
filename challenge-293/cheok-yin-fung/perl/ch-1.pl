# The Weekly Challenge 293
# Task 1 Similar Dominos
use v5.30;
use warnings;

sub sd {
    my @dominos = $_[0]->@*;
    my %similarity;
    for my $i (0..$#dominos-1) {
        for my $j ($i+1..$#dominos) {
            if (
                ($dominos[$i]->[0] == $dominos[$j]->[0] 
                                &&
                $dominos[$i]->[1] == $dominos[$j]->[1])
                        ||
                ($dominos[$i]->[1] == $dominos[$j]->[0] 
                                &&
                $dominos[$i]->[0] == $dominos[$j]->[1])) 
            {
                $similarity{$i} = 1;
                $similarity{$j} = 1;
            }
        }
    }
    my $ans = scalar keys %similarity;
    return $ans;
}

use Test::More tests=>2;
ok sd([[1, 3], [3, 1], [2, 4], [6, 8]]) == 2;
ok sd([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]) == 3;
