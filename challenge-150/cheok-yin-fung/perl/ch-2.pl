# The Weekly Challenge 150
# Task 2 Square-Free Numbers
# Usage: $ ch-2.pl [upper_bound]

use v5.22.0;
use warnings;

my $N = $ARGV[0] || 500;

say join ", ", sq_free($N)->@*;



sub sq_free {
    my $n = $_[0];
    my @is_sqfree = (1) x ($n+1);

    my $sqrtn = int sqrt $n;
    for my $i (2..$sqrtn) {
        for my $j (1..$n/$i) {
           $is_sqfree[$i*$i*$j] = 0;
        }
    }
    return [grep {$is_sqfree[$_]} (1..$n)];
}



use Test::More tests => 1;
use Test::Deep;
cmp_deeply(sq_free(30), [1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30]);

# REF: https://stackoverflow.com/a/5313337 ,
#      http://mathworld.wolfram.com/Squarefree.html
