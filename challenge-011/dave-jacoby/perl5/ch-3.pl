#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch fc };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Using Open Weather Map API, write a script to fetch
# the current weather for an arbitrary city.
# Note that you will need to sign up for Open Weather Map's
# free tier and then wait a couple hours before your API key
# will be valid. This challenge was proposed by Joelle Maslak.
# The API challenge is optional but would love to see your solution.

# usage: ./pc011c3.pl london,uk washington,us paris

use JSON;
use Mojo::UserAgent;
use YAML qw{LoadFile};

my $json = JSON->new->pretty->canonical;
my $mojo = Mojo::UserAgent->new;

my $conf = LoadFile join '/', $ENV{HOME}, '.openweather.yml';
my $key  = $conf->{key};

for my $location (@ARGV) {
    my $query    = {
        q     => $location,
        appid => $key,
    };

    my $url = 'https://api.openweathermap.org/data/2.5/weather';
    my $res = $mojo->get( $url => form => $query )->result;
    if ( $res->is_success ) {
        my $obj = $json->decode( $res->body );
        say $json->encode($obj);
    } else {
        say $res->{code};
    }
}

# OK, verbose in JSON and not quite readable, but it fulfills the 
# letter of the challenge.
