#!/usr/bin/env perl
#
# ch-1.pl - Complete Day
#
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw< sum0 reduce>;

# If any pair of numbers is a multiple of 24, return the count of
# such matching pairs. Assumption: pairs are WITH replacement.
sub complete_day {
    my $count = 0;
    while (my $m = shift) {
        $count += sum0 map { ($m + $_) % 24 == 0 } @_
    }
    $count
}

sub complete_day_functional {
    sum0 map { my $m = shift @$_; map { ($m + $_) % 24 == 0 } @$_ }
         map { [ @_[$_ .. $#_] ] } 0..$#_
}

use Test::More;

is complete_day(qw<12 12 30 24 24>), 2 => 'Example 1';
is complete_day(qw<72 48 24 5>),     3 => 'Example 2';
is complete_day(qw<12 18 24>),       0 => 'Example 3';
is complete_day(),                   0 => 'Empty list';

done_testing;
