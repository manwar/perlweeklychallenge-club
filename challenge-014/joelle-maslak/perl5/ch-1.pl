#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

die("Usage: $0 <number of sequence elements>") unless @ARGV <= 1;
my $length = $ARGV[0] // 19;

sub MAIN() {
    say join ' ', map { van_eck($_) } 0..($length-1);
}

my %cache_by_val = (0 => [0, 1]);
my @cache_by_pos = (0, 0);

sub van_eck($pos) {
    return 0 if $pos <= 1;

    return $cache_by_pos[$pos] if exists $cache_by_pos[$pos];

    # Ensure cache is populated
    for (my $p=0; $p<$pos; $p++) { van_eck($p) }

    my $n = $pos - 1;

    # We know that we must have been called in order.
    my $prev = van_eck($n);

    my $current;
    if (exists $cache_by_val{$prev} and scalar($cache_by_val{$prev}->@*) >= 2) {
        my $m = $cache_by_val{$prev}->[-2];
        $current = $n - $m;
    } else {
        $current = 0;
    }
    $cache_by_pos[$pos] = $current;
    $cache_by_val{$current} = [] unless exists $cache_by_val{$current};
    push $cache_by_val{$current}->@*, $pos;

    return $current;
}

MAIN();

