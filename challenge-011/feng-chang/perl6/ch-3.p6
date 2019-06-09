#!/bin/env perl6

use HTTP::UserAgent;
use JSON::Tiny;
use Data::Dump;

my Str $base_url = 'http://api.openweathermap.org/data/2.5/weather';
my Str $app_id   = 'appid=82642c9af842d8d57f7df99b291e0e75';

sub MAIN(
    Str :$city    = 'london',
    Str :$country = '',
) {
    my $ua = HTTP::UserAgent.new;

    my $url = "$base_url?q={ $city }{ (',' ~ $country) if $country }&$app_id";

    my $resp = $ua.get($url);
    if $resp.is-success {
        say Dump(from-json($resp.content));
    } else {
        say 'fetch error';
    }
}
