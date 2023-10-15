# The Weekly Challenge 238
# Task 2 Persistence Sort
use v5.30.0;
use warnings;
use List::Util qw/product/;

sub psort {
    my @int = @_;
    my %persist;
    sub find_persist {
        my $persist = 0;
        my $res = $_[0];
        while ($res >= 10) {
            $res = product split "", $res;
            $persist++;
        }
        return $persist;
    }
    for my $i (@int) {
        $persist{$i} = find_persist($i);
    }
    return [sort { $persist{$a} <=> $persist{$b} || $a <=> $b } @int]
}

use Test::More tests=>2;
use Test::Deep;
cmp_deeply psort(15, 99, 1, 34), [1, 15, 34, 99];
cmp_deeply psort(50, 25, 33, 22), [22, 33, 50, 25];
