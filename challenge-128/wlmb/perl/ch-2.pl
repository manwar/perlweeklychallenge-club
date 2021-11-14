#!/usr/bin/env perl
# Perl weekly challenge 128
# Task 2: Minimum platforms
#
# See https://wlmb.github.io/2021/08/30/PWC128/#task-2-minimum-platforms
use warnings;
use strict;
use v5.12;
use List::MoreUtils qw(pairwise);
use PDL;

my ($arrive, $depart)=@ARGV; # Assume format "hh:mm hh:mm..." for each arg.
my @arrive=map {to_minutes($_)}  split ' ', $arrive;
my @depart=map {to_minutes($_)}  split ' ', $depart;
die "Expected same number of arrivals and departures" unless @arrive==@depart;

# Classify departures: after or 'before' arrival
my @DaA=map {$depart[$_]} grep {$depart[$_] > $arrive[$_]} 0..$#depart; # after
my @DbA=map {$depart[$_]} grep {$depart[$_] <= $arrive[$_]} 0..$#depart; # before

# Put all event codes  in a single chronologically ordered array.
# If a departure and an arrival coincide, arrival goes first. Discard time after sorting.
my @events=map {$_->{type}} sort {$a->{time}<=>$b->{time}|| $a->{type} <=> $b->{type}}
	       map {my $t=$_; my $r=(\@arrive, \@DaA, \@DbA)[$_];
                    map {{time=>$_, type=>$t}} @$r } 0..2;
my $events=pdl(@events); # Ordered vector of event codes

my $effects=zeroes(scalar @events, scalar @events); # effects of each event
my @type=qw(Arrive Depart Depart(prev)); # Types of events, coded as 0,1,2
$effects=((($events==0) & ($effects->xvals <= $effects->yvals)) # arrivals +1
         -(($events==1) & ($effects->xvals <  $effects->yvals)) # departures -1
         +(($events==2) & ($effects->xvals >= $effects->yvals))); # previous arrival +1

my $trains=$effects->sumover; # trains at station at given events
my $platforms=$trains->max;   # required platforms

say "Arrivals: $arrive\nDepartures: $depart\nOutput: $platforms platforms";
say "Trains at station: $trains";
say "Events: ", map {"$type[$_] "} list($events);

sub to_minutes { # convert HH:MM to minutes. Allow fractional minutes HH:MM.FFF
    my $time=shift @_;
    die "Wrong time format: $time" unless $time=~m/(^\d+):(\d+(\.\d*)?)$/;
    my ($hour, $minute)=($1,$2);
    die "Falied 0<=hour<24: $time" unless 0<=$hour<24;
    die "Failed 0<=minute<60: $time" unless 0<=$minute<60;
    return $hour*60+$minute;
}
