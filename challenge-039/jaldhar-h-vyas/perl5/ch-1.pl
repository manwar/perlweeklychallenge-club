#!/usr/bin/perl
use warnings;
use strict;
use English qw/-no_match_vars /;
use 5.010;

sub time2minutes {
    my $time = shift;
    my ($hours, $minutes) = split q{:}, $time;

    return $hours * 60 + $minutes;
}


my $earliest = "Inf";
my $latest = "-Inf";

my $file = open my $fh, '<', 'guestbook.txt' or die "$OS_ERROR\n";
local $RS = undef;
my $data = <$fh>;
close $fh;

my @lines = split /\n/, $data;

for my $line (@lines) {
    my ($in, $out) = map { time2minutes($_) } (split /\s+/, $line)[3, 5];
    if (defined $in && defined $out) {

        if ($in < $earliest) {
            $earliest = $in;
        }

        if ($out > $latest) {
            $latest = $out;
        }
    }
}

say 'The lights were on for ', $latest - $earliest, ' minutes.';
