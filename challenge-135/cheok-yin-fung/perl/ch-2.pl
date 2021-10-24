# The Weekly Challenge 135
# Task 2 Validate SEDOL
# Usage: ch-2.pl [SEDOL]
use v5.12.0;
use warnings;
use Test::More tests => 4;

say sedol($ARGV[0]) ? 1 : 0;

sub sedol {
    return 0 if !defined($_[0]);
    my %val;
    $val{$_} = $_ for (0..9);
    $val{$_} = ord($_)-ord("A")+10 for ("A".."Z");

    my @arr = split //, $_[0];
    my @weight = (1,3,1,7,3,9);
    my $sum = 0;
    for (0..5) {
        $sum += $val{$arr[$_]}*$weight[$_];
    }
    return ((840-$sum) % 10) == $arr[-1];
}


ok sedol('2936921') == 1, "Example 1";
ok sedol('1234567') == 0, "Example 2";
ok sedol('B0YBKL9') == 1, "Example 3";
ok sedol('0263494') == 1, "Example from wikipedia";
