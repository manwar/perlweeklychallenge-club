#!/usr/bin/env perl
#
# Write a script to use Language Detection API
# (https://detectlanguage.com/)
################################################################################

use strict;
use warnings;

use HTTP::Request;
use LWP::UserAgent;
use JSON qw<encode_json decode_json>;

# API key read from environment
my $APIKEY = $ENV{'DETECTLANGUAGEAPI_KEY'} or die "DETECTLANGUAGEAPI_KEY not defined";
my $TEXT = join " ", @ARGV or die "Usage: $0 <text>\n";

my $ua = LWP::UserAgent->new;
$ua->agent("gramos's script for perlweeklychallenge.org");
my $uri = "https://ws.detectlanguage.com/0.2/detect";
my @headers = ("Authorization" => "Bearer $APIKEY",
               "Content-Type" => "application/json");
my $body = encode_json { q => $TEXT };

my $response = $ua->request(HTTP::Request->new("POST", $uri, \@headers, $body));

# Check for errors in API request
die "Unknown error: " . $response->message if $response->is_error();

# Extract detection list
my $detections = (decode_json $response->content)->{'data'}{'detections'};

my $det = $detections->[0] or die "No detections :(";
printf "Language: '%s' (confidence = %s), %sreliable\n",
    $det->{language}, $det->{confidence}, $det->{isReliable} ? "" : "not ";
