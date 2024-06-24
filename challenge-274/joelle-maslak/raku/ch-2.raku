#!/usr/bin/env raku
use v6.d;

class RouteText {
    has $.interval;
    has $.offset;
    has $.travel_time;
}

class Best {
    has $.total_time is rw;
    has $.nextbus is rw;
    has $.skip is rw;
}

my $input = @*ARGS.join("");
$input ~~ s:g/\s+//;
$input ~~ s/^\[\[//;
$input ~~ s/\]\]$//;

my @routes;
my (@routetext) = $input.split("],[");
for @routetext -> $routetext {
    my ($interval, $offset, $travel_time) = $routetext.split(",");
    my $route = RouteText.new(interval => $interval, offset => $offset, travel_time => $travel_time);
    @routes.append: $route;
}

my @out;
for (0..59) -> $minute {
    my $best = Best.new();
    for @routes -> $route {
        my $iteration = 0;
        my $bus_at = Int(($minute + $route.interval - $route.offset - 1) / $route.interval) * $route.interval + $route.offset;
        my $total_time = $bus_at - $minute + $route.travel_time;

        if !defined($best.nextbus) or $best.nextbus > $bus_at {
            $best.nextbus = $bus_at;
            $best.total_time = $total_time;
            $best.skip = 0;  # False
            next;
        }

        if $total_time < $best.total_time {
            $best.total_time = $total_time;
            if $best.nextbus < $bus_at {
                # We only skip if the two bueses aren't at the same time1
                $best.skip = 1;
            }
        }
    }
    if $best.skip {
        @out.append: $minute;
    }
}

say "[" ~ @out.join(", ") ~ "]";
