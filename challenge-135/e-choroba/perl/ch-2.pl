#!/usr/bin/perl
use warnings;
use strict;
use experimental 'regex_sets';

my $LENGTH = my @WEIGHTS = (1, 3, 1, 7, 3, 9, 1);
sub validate_sedol {
    my ($s) = @_;
    return 0 if $s !~ /\A(?[[0-9A-Z] - [AEIOU]]){$LENGTH}\z/;

    my @nums = map { $_ =~ /[0-9]/ ? $_ : ord($_) - ord 'A'} split //, $s;
    my $sum = 0;
    $sum += $nums[$_] * $WEIGHTS[$_] for 0 .. $#WEIGHTS;
    return $sum % 10 ? 0 : 1
}

use Test2::V0;
plan 18;

is validate_sedol('2936921'), 1,
    'Example 1';

is validate_sedol('1234567'), 0,
    'Example 2';

is validate_sedol('B0YBKL9'), 1,
    'Example 3';

is validate_sedol('B0ABKL3'), 0,
    'No vowels';

is validate_sedol('B0BKL3'), 0,
    'Wrong length';

is validate_sedol('B0AbKL3'), 0,
    'Invalid char';

is validate_sedol('0263494'), 1,
    'BAE Systems';

is validate_sedol($_), 1, "Rosetta $_"
    for qw( 7108899 B0YBKJ7 4065663 B0YBLH2 2282765 B0YBKL9
            5579107 B0YBKR5 5852842 B0YBKT7 B000300 );
