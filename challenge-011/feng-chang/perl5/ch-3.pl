#!/bin/env perl

use Modern::Perl;
use WWW::Mechanize;
use JSON;
use Data::Dumper;
use Getopt::Long;

my $base_url = 'http://api.openweathermap.org/data/2.5/weather';
my $app_id   = 'appid=82642c9af842d8d57f7df99b291e0e75';

my $city    = 'london';
my $country = '';

GetOptions(
    'city=s'    => \$city,
    'country=s' => \$country,
);

my $m = WWW::Mechanize->new()  or  die "cannot initialize robot\n";

my $url = "$base_url?q=$city";
$url   .= ",$country" if $country;
$url   .= "&$app_id";

print Dumper(decode_json($m->content)) if $m->get($url);
