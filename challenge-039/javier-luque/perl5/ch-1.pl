#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

my $minutes_on = calculate_lights_on();

say 'Lights on for: ' .
    $minutes_on . ' minutes';

# Calculate the minutes lights were on
sub calculate_lights_on {
    my %time_on; # Sample in minutes
    my $time_re = qr/\d{2}\:\d{2}/;

    while (my $line = <DATA>) {
        next unless $line =~
            /.*?($time_re).*?($time_re)/;

        # Get the time in absolute minutes
        my $t1 = absolute_minutes($1);
        my $t2 = absolute_minutes($2);

        # Populate the time on hash
        for my $minute ($t1 .. ($t2 - 1)) {
            $time_on{$minute} = 1;
        }
    }

    return scalar(keys %time_on);
}

# Convert to absolute mins.
sub absolute_minutes {
    my ($hh, $mm) = split(':', shift);
    return $hh * 60 + $mm;
}


__DATA__
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
