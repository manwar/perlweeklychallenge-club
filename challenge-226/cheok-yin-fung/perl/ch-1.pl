# The Weekly Challenge 226
# Task 1 Shuffle String
use v5.30.0;
use warnings;

sub ss {
    my $string = $_[0];
    my @indices = $_[1]->@*;
    my @chars = split "", $string;
    my $ans = join "", map {$chars[$_]} 
              sort {$indices[$a] <=> $indices[$b]} 0..$#chars;
    return $ans;
}

use Test::More tests => 2;
ok ss('lacelengh', [3,2,0,5,4,8,6,7,1]) eq 'challenge';
ok ss('rulepark', [4,7,3,1,0,5,2,6]) eq 'perlraku';
