#!/usr/bin/perl
# The Weekly Challenge 128
# Task 2 Minimum Platforms
# Usage: $ ch-2.pl arrival timetable x departure timetable
use v5.12.0;
use warnings;
use List::Util qw/any/;
use Data::Dumper;
use Test::More tests => 2;

my (@a, @a1, @a2);
@a = @ARGV;
@a = ("08:00", "15:30", "04:11", 'x', "15:00", "18:00", "09:27") 
    if !defined($ARGV[0]);
my $i = 0;

while ($a[$i] ne 'x' && $i < scalar @a) {
    push @a1, $a[$i];
    $i++;
}

$i++;

while ($i < scalar @a) {
    push @a2, $a[$i];
    $i++;
}

die if scalar @a1 != scalar @a2;

say "\@arrivals  : ", "@a1";
say "\@departures: ", "@a2";
say "minimum number of platform(s) needed:";
say platforms_needed( 
    [map {hourmin_to_min($_)} @a1 ],  
    [map {hourmin_to_min($_)} @a2 ]
);



sub hourmin_to_min {
    my $s = $_[0];
    $s =~ m/(\d+):(\d+)/;
    return $1*60 + $2;
}



sub platforms_needed {
    my @arrive_min = $_[0]->@*;
    my @depart_min = $_[1]->@*;
    my %station_traffic; 
    for (@arrive_min) {
        if (defined($station_traffic{$_})) {
            $station_traffic{ $_ }++;
        }
        else {
            $station_traffic{ $_ } = 1;
        }
    }
    for (@depart_min) {
        if (defined($station_traffic{$_})) {
            $station_traffic{ $_ }--;
        }
        else {
            $station_traffic{ $_ } = -1;
        }
    }

    my @events = sort {$a<=>$b} keys %station_traffic;
    my $status = 0;
    my $max_status = 0;
    for (@events) {
        $status += $station_traffic{ $_ };
        $max_status = $status if $status > $max_status;
    }
    return $max_status;
}



sub platforms_needed_primitive {
    # An assumption: 
    # neither two trains arrive at the same 
    # time nor leave at the same time
    my @arrive_min = $_[0]->@*;
    my @depart_min = $_[1]->@*;

    my $p = 0;
    my $max_p = 0;
    for my $t (0..1439) {
        $p++ if any { $t == $_ } @arrive_min;
        $max_p = $p if $p > $max_p;
        $p-- if any { $t == $_ } @depart_min;
    }

    return $max_p;
}


ok platforms_needed(
    [ 11*60+20, 14*60+30 ], 
    [ 11*60+50, 15*60 ] 
) == 1,
"Example 1";

ok platforms_needed(
    [ 10*60+20, 11*60+00, 11*60+10, 12*60+20, 16*60+20, 19*60+00 ], 
    [ 10*60+30, 13*60+20, 12*60+40, 12*60+50, 20*60+20, 21*60+20 ] 
) == 3,
"Example 2";   
