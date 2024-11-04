#https://theweeklychallenge.org/blog/perl-weekly-challenge-293/

use strict; use warnings;

sub similar_dominos {
    my %freq;
    $freq{ "@{[ sort @$_ ]}" }++ for @_;
    eval join '+', grep $_ > 1, values %freq;
}

print similar_dominos(map[split],"@ARGV"=~/\d+\s*\d+/g) and exit if @ARGV;

use Test::More;
is similar_dominos( [1, 3], [3, 1], [2, 4], [6, 8] )         => 2;
is similar_dominos( [1, 2], [2, 1], [1, 1], [1, 2], [2, 2] ) => 3;
done_testing;
