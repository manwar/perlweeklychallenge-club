#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

sub compute_time {
    my ($y, $mo, $d) = split /-/, shift;
    my ($h, $mi, $s) = (0, 0, 0);
    $mo -= 1; # months are 0-indexed
    # $y -= 1900; # timegm works better with real year
    # say $y;
    return timegm($h, $mi, $s, $d, $mo, $y);
}
sub convert_date {
    my $time_stamp = shift;
    my ($d, $m, $y) = (gmtime $time_stamp)[3, 4, 5];
    $d = sprintf "%02d", $d;
    $m = sprintf "%02d", $m+1;
    $y += 1900;
    return "$y-$m-$d";
}

my $today =  compute_time("2021-09-22");  # timestamp for the date arbitrarily chosen as "today"
for my $test ("2021-09-18", "1975-10-10", "1967-02-14") {
    my $input = compute_time ($test);
    my $time_diff = $today - $input;
    my @output = ($input - $time_diff, $today + $time_diff);
    say "Mirror dates for $test are: ", convert_date($output[0]), " and ", convert_date($output[1]);
}
