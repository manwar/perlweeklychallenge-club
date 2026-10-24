#!/usr/bin/perl
use 5.40.1;
use warnings;

my @arrivals = map { [split q{:}, $_] } split /\s+/, $ARGV[0];
my @departures = map { [split q{:}, $_] } split /\s+/, $ARGV[1];

my @arrivalTimes =  sort { $a <=> $b } map { $_->[0] * 60 + $_->[1] } @arrivals;
my @departureTimes = sort { $a <=> $b } map { $_->[0] * 60 + $_->[1] } @departures;
my $arrival = 0;
my $departure = 0;
my $platforms = 0;
my $minimum = 0;

while ($arrival < scalar @arrivalTimes) {
    if ($arrivalTimes[$arrival] < $departureTimes[$departure]) {
        $platforms++;
        if ($platforms > $minimum) {
            $minimum = $platforms;
        }
        $arrival++;
    }
    else {
        $platforms--;
        $departure++;
    }
}

say $minimum;
