#!/usr/bin/env perl6

#Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.

use DateTime::Format;
use HTTP::UserAgent;

sub GetDaytime($url) {
    my $ua = HTTP::UserAgent.new;
    $ua.timeout = 10;

    my $response = $ua.get($url);

    return $response.content if $response.is-success;
    die    $response.status-line;
}

sub MAIN($year = 2019) {
    my $daytimeDec = GetDaytime('https://www.timeanddate.com/sun/uk/london?month=12&year=2019');
    my $daytimeNov = GetDaytime('https://www.timeanddate.com/sun/uk/london?month=11&year=2019');

    say $daytimeDec.content;
}