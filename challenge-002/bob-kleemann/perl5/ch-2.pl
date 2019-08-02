#! /usr/bin/env perl

use v5.18.0;
use warnings;

my $base       = 0;
my %digits     = map { $_ => $base++ } "0" .. "9", "a" .. "y";
my $base_chars = join( "" => keys(%digits) );

while (<>) {
    s/^[^$base_chars]*//i;             # Remove leading junk
    ($_) = split /[^$base_chars]/i;    # Remove trailing junk
    my $n = 0;
    $n = $base * $n + $digits{ lc() } foreach split //;
    say "base$base(", $_, ') == ', $n;
}
