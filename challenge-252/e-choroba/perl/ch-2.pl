#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub unique_sum_zero($n) {
    return [(0) x ($n % 2), map { $_, -$_ } 1 .. $n / 2]
}

use Test::More tests => 7;
use List::Util qw{ sum uniq };

subtest "n=$_" => sub {
    plan tests => 3;
    my $output = unique_sum_zero($_);
    is scalar @$output, $_, 'length';
    my @u = uniq(@$output);
    is scalar @u, $_, 'uniq';
    is sum(@$output), 0, 'sum 0';
} for 1 .. 7;
