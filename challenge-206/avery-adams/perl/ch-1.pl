#!/usr/bin/perl

use strict;
use v5.10;

use DateTime;

my @times = @ARGV;
my $closest;

if (scalar @times < 2) {
    say "I didn't get enough times to process.";
} else {
    for (my $index1 = 0; $index1 <= scalar @times - 2; $index1++) {
        for (my $index2 = $index1 + 1; $index2 <= scalar @times - 1; $index2++) {
            my ($hours1, $minutes1) = ($times[$index1] =~ /(\d\d):(\d\d)/);
            my ($hours2, $minutes2) = ($times[$index2] =~ /(\d\d):(\d\d)/);
            my $datetime1 = DateTime->new(
                year   => 2023,
                day    => 1,
                hour   => $hours1,
                minute => $minutes1
            );
            my $datetime2 = DateTime->new(
                year   => 2023,
                day    => 2,
                hour   => $hours1,
                minute => $minutes1
            );
            my $datetime3 = DateTime->new(
                year   => 2023,
                day    => 1,
                hour   => $hours2,
                minute => $minutes2
            );
            my $delta1 = $datetime3->delta_ms($datetime1);
            my $delta2 = $datetime3->delta_ms($datetime2);
            if ($delta1->in_units('minutes') <= $delta2->in_units('minutes')) {
                if ($delta1->in_units('minutes') < $closest) {$closest = $delta1->in_units('minutes')};
                if (!defined($closest)) {$closest = $delta1->in_units('minutes')};
            } else {
                if ($delta2->in_units('minutes') < $closest) {$closest = $delta2->in_units('minutes')};
                if (!defined($closest)) {$closest = $delta2->in_units('minutes')};
            }
        }
    }
    say "The closest numbers are $closest minutes apart.";
}
