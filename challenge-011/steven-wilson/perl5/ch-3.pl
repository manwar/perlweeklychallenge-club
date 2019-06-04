#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-03
# Week: 011
# Challenge: #3
#
# Using Open Weather Map API, write a script to fetch the current weather for
# an arbitrary city. Note that you will need to sign up for Open Weather Map’s
# free tier and then wait a couple hours before your API key will be valid.
# This challenge was proposed by Joelle Maslak. The API challenge is optional
# but would love to see your solution.
# https://openweathermap.org/current
# usage: $ ./ch-3.pl London
# or:    $ ./ch-3.pl "London, US"

use strict;
use warnings;
use feature qw / say /;
use Switch;
use LWP::Simple;
use JSON::MaybeXS;

my $API_KEY = "5f1b876baa129252e557f43d029e974b";
my $city    = $ARGV[0];

my $api_call_url
    = "http://api.openweathermap.org/data/2.5/weather?"
    . "q=$city"
    . "&APIKEY=$API_KEY";
my $filename = "weather." . lc($city) . ".json";
my $content;
my $data_structure;

if ( -s $filename and -M $filename < 0.0069 ) {
    open my $fh, '<', $filename or die "Cannot read '$filename': $!\n";
    $content        = <$fh>;
    $data_structure = decode_json($content);
    close $fh;
}
else {
    $content = get($api_call_url);
    die "Couldn't get it!" unless defined $content;
    $data_structure = decode_json($content);
    open my $fh, '>', $filename or die "Cannot write '$filename': $!\n";
    print $fh $content;
    close $fh;
}

my %weather = %{$data_structure};
my $condition;
my $item;

switch ( $weather{"weather"}[0]{id} ) {
    case [ 200 .. 232 ] { $condition = "thundery"; $item = "golf club" }
    case [ 300 .. 321 ] { $condition = "drizzly";  $item = "lemon cake" }
    case [ 500 .. 531 ] { $condition = "rainy";    $item = "wellies" }
    case [ 600 .. 622 ] { $condition = "snowy";    $item = "sledge" }
    case [ 701 .. 781 ] {
        $condition = "low visability";
        $item      = "flashlight"
    }
    case [800] { $condition = "clear skies"; $item = "sunscreen" }
    case [ 801 .. 804 ] {
        $condition = "cloudy";
        $item      = "imagination, what shapes can you see?"
    }
}

say "Another $condition day in old "
    . $weather{"name"}
    . " town, don't forget your $item.";