# The Weekly Challenge 282
# Task 2 Changing Keys
use v5.30.0;
use warnings;
use List::Util qw/reduce/;

sub ck {
    my $str = $_[0];
    return 0 if $str eq "";
    $str = lc $str;
    my @alphabets = split "", $str;
    my $abc = reduce { substr($a,-1) eq $b ? $a : $a.$b } @alphabets;
    return ((length $abc) - 1);
}

use Test::More tests=>3;
ok ck("pPeERrLl") == 3;
ok ck("rRr") == 0;
ok ck("GoO") == 1;
