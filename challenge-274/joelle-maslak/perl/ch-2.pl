#!/usr/bin/perl

use JTM::Boilerplate 'script';

MAIN: {
    my $input = join '', @ARGV;
    $input =~ s/\s+//g;
    $input =~ s/^\[\[//;
    $input =~ s/\]\]$//;

    my @routes;
    my (@routetext) = split /],\[/, $input;
    for my $routetext (@routetext) {
        my ($interval, $offset, $travel_time) = split /,/, $routetext;
        my $route = {
            interval => $interval,
            offset => $offset,
            travel_time => $travel_time,
        };
        push @routes, $route;
    }

    my @out;
    for my $minute (0..59) {
        my $best = {
            next => undef,
        };
        for my $route (@routes) {
            my $iteration = 0;
            my $bus_at = int(($minute + $route->{interval} - $route->{offset} - 1) / $route->{interval}) * $route->{interval} + $route->{offset};
            my $total_time = $bus_at - $minute + $route->{travel_time};

            if (!defined($best->{next}) or $best->{next} > $bus_at) {
                $best->{next} = $bus_at;
                $best->{total_time} = $total_time;
                $best->{skip} = 0;  # False
                next;
            }

            if ($total_time < $best->{total_time}) {
                $best->{total_time} = $total_time;
                if ($best->{next} < $bus_at) {
                    # We only skip if the two bueses aren't at the same time1
                    $best->{skip} = 1;
                }
            }
        }
        if ($best->{skip}) {
            push @out, $minute;
        }
    }

    say "[" . join(", ", @out) . "]"
}
