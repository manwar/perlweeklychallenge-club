use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util 'any';

sub diff_pair($a, $n, $i = 0) {
    return 0 if $i > @{$n} - 1;
    return 1 if any { abs($n->[$i] - $_) == $a } $n->@[$i + 1 .. @{$n} - 1];
    return diff_pair($a, $n, $i + 1);
}

if (@ARGV > 0) {
    say diff_pair(shift(@ARGV), \@ARGV);
    exit 0;
}

use Test::More;

ok  diff_pair(7, [10, 8, 12, 15, 5]);
ok  diff_pair(6, [1, 5, 2, 9, 7]);
ok !diff_pair(6, [10, 30, 20, 50, 40]);

done_testing();
