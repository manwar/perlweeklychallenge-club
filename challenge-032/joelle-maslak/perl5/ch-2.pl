#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use List::Util qw(max min);

MAIN: {
    my $csv;
    my $screen_width = 80;
    my $base;
    my $deliminator = "\t";

    GetOptions(
        "csv" => \$csv,
        "screen-width=i" => \$screen_width,
        "base=i" => \$base,
        "deliminator=s" => \$deliminator,
    );

    my @words;
    while (my $lines = <<>>) {
        chomp $lines;
        my (@parts) = split "$deliminator", $lines;

        die "All lines must have one and only one deliminator" unless scalar(@parts) == 2;

        push @words, \@parts;
    }

    my $maxlen = max map { length $_->[0] } @words;
    my $maxval = max map { $_->[1] } @words;
    my $minval = min map { $_->[1] } @words;

    $base //= $minval;
    die "Base should be less or equal to minimum value" unless $base <= $minval;

    my $spread = $maxval - $base;     # How far apart are max and min?
    my $maxbar = $screen_width - $maxlen - 4; # How big the bar can be, we don't use the last column
    my $unitsize = $maxbar ? ($spread / $maxbar) : 0; # What a '#' represents

    foreach my $ele (@words) {
        my $hashes = int(($ele->[1] - $base) / $unitsize);
        $hashes = $maxbar if $unitsize == 0;

        say sprintf("%-${maxlen}s", $ele->[0]) . " | " . ("#" x $hashes);
    }
}
