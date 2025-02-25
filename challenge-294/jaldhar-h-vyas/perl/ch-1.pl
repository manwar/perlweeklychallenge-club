#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my %nums = map { $_ => 1 } @ints;

my $longest = 0;

foreach my $i (@ints) {
    unless ($nums{$i - 1}) {
        my $current = $i;
        my $length = 1;

        while ($nums{$current + 1}) {
            $current++;
            $length++;
        }

        if ($length > $longest) {
            $longest = $length;
        }
    }
}

say $longest > 1 ? $longest : -1;

