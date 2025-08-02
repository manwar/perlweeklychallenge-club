#!/usr/bin/perl
use v5.38;

my %timetable;

for my $route (@ARGV) {
    my ($freq, $start, $time) = split /\s+/, $route;
    my $departure = $start;
    while ($departure < 60) {
        $timetable{$departure} = $departure + $time;
        $departure += $freq;
    }
}

my @starts = sort { $a <=> $b } keys %timetable;
my @output;

for my $minute (0 .. 59) {
    my $next = 0;
    for my $s (keys @starts) {
        if ($starts[$s] >= $minute) {
            $next = $s;
            last;
        } 
    }
    my $later =  $next == (scalar @starts - 1) 
        ? $timetable{$starts[0]} + 60
        : $timetable{$starts[$next + 1]};

    if ($timetable{$starts[$next]} > $later) {
        push @output, $minute;
    }
}

say q{[}, (join q{, }, @output), q{]};
