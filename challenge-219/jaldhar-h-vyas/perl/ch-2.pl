#!/usr/bin/perl
use 5.030;
use warnings;

my ($days, @costs) = @ARGV;

my @days =  sort {$a <=> $b } map { 0 + $_ } split /\s+/, $days;

my %costs;
$costs{1} = $costs[0];
$costs{7} = $costs[1];
$costs{30} = $costs[2];

my @q;
push @q, { cost => 0, days => \@days };
my $lowestCost = (scalar @days) * $costs{'1'};

while (scalar @q) {
    my %entry = %{ shift @q };

    if ( scalar @{$entry{days}} == 0 ) {
        if ( $entry{cost} < $lowestCost ) {
            $lowestCost = $entry{cost}; 
        }
    } else {
        if ( $entry{cost} >= $lowestCost ) {
            next;
        }

        my $start = $entry{days}->[0];
        for my $interval (keys %costs) {
            my $end = $start + $interval - 1;
            my $cost = $entry{cost} + $costs{$interval};
            push @q, {
                cost => $cost,
                days => [ grep { $_ > $end } @{$entry{days}} ]
            };
        }
    }
}

say $lowestCost;
