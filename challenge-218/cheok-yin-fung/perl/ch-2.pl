# The Weekly Challenge 218
# Task 2 Matrix Score

use v5.30.0;
use warnings;
use List::Util qw/max sum/;

sub toggle_or_not {
    return [@_] if $_[0] == 1;
    # if $_[0] == 0
    my @ans = map {0+!$_} @_;
    return [@ans];
}

sub ms {
    my @old_rows = $_[0]->@*;
    my @rows;
    foreach (@old_rows) {
        push @rows, toggle_or_not($_->@*);
    }
    my $score = 0;
    my $height = scalar @rows;
    my $len = $rows[0]->$#*;
    for my $col (reverse 0..$len) {
        my $ones = sum map {$rows[$_][$col]} 0..$#rows;
        $score += 2**($len-$col) * max($height-$ones, $ones);
    }
    return $score;
}


use Test::More tests=>2;
ok ms( [ [0,0,1,1],
      [1,0,1,0],
      [1,1,0,0], ]) == 39;
ok ms([[0]]) == 1;
