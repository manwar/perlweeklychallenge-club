#!/usr/bin/perl
use 5.038;
use warnings;

my ($time) = @ARGV;

my $possibilities = 0;
my ($hourTens, $hourOnes, undef, $minuteTens, $minuteOnes) = split //, $time;

if ($hourTens eq q{?} && $hourOnes eq q{?}) {
    $possibilities = 24;
} elsif ($hourTens eq q{?}) {
    $possibilities = ($hourOnes >= 0 && $hourOnes <= 3) ? 3 : 2; 
} elsif ($hourOnes eq q{?}) {
    $possibilities = ($hourTens == 2) ? 4 : 10;
} else {
    $possibilities = 1;
}

if ($minuteTens eq q{?} && $minuteOnes eq q{?}) {
    $possibilities *= 60;
} elsif ($minuteTens eq q{?}) {
    $possibilities *= 6; 
} elsif ($minuteOnes eq q{?}) {
    $possibilities *= 10;
}  else {
    if $possibilities == 1 {
        $possibilities = 0;
    }
}

say $possibilities;
