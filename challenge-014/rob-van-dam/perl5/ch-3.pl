#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

use HTTP::Tiny;
use URI::Escape;
use JSON::PP qw(decode_json);
use Data::Dumper;

my $base = 'http://geodb-free-service.wirefreethought.com';
my $find = '/v1/geo/cities?limit=10&offset=0&namePrefix=%s';
my $time = '/v1/geo/cities/%d/time';

my $search = shift @ARGV || 'New Orleans';
my @cities = find_cities($search);

binmode STDOUT, ":utf8"; # avoid wide character warnings on certain results
foreach my $city (@cities) {
    say $city->{'name'}, ', ', $city->{'regionCode'}, ', ', $city->{'countryCode'}, ': ', get_time($city->{'id'});
}

sub find_cities {
    my $search = shift;

    my $url = sprintf $base . $find, uri_escape($search);
    return @{ _get($url) };
}

sub get_time {
    my $city_id = shift;

    my $url = sprintf $base . $time, $city_id;
    return _get($url);
}

sub _get {
    my $url = shift;

    my $response = HTTP::Tiny->new->get($url);
    my $parsed = decode_json($response->{'content'});
    return $parsed->{'data'};
}
