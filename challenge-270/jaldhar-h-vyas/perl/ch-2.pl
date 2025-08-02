#!/usr/bin/perl
use v5.38;

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

sub pick($count, @arr) {
    my %results;
    my $picked = 0;

    while ($picked < $count) {
        my $random = $arr[int(rand(scalar @arr))];
        unless (exists $results{$random}) {
            $results{$random} = 1;
            $picked++;
        }
    }

    return wantarray ? keys %results : [ keys %results ];
}

my ($x, $y, @ints) = @ARGV;

my $max = max(@ints);
my @unequals = @ints;
my $cost = 0;

while(1) {
    @unequals = grep { $_ != $max } @unequals;
    my $remaining = scalar @unequals;

    if ($remaining > 1) {
        for my $pick (pick(2, keys @unequals)) {
            $unequals[$pick]++;
        }
        $cost += $y;

    } elsif ($remaining == 1) {
        $unequals[0]++;
        $cost += $x;

    } else {
        last;
    }
}

say $cost;
