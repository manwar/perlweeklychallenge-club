#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-01
# Week: 015
# Challenge: #3
#
# Write a script to use Language Detection API. For more information
# about API, please visit page. The API task is optional but we would
# love to see your solution.
# https://detectlanguage.com/
# e.g. usage: $perl ch-3.pl "HeghluʼmeH QaQ jajvam."
#     output: The following text has been analysed: 'HeghluʼmeH QaQ jajvam.'
#             It was found to be written in Klingon.  The confidence
#             value was 18.61 and this is thought to be reliable.

use strict;
use warnings;
use feature qw / say /;
use LWP::UserAgent;
use JSON::MaybeXS;
use YAML::XS 'LoadFile';

my $config         = LoadFile('detect.yml');
my $text           = $ARGV[0];
my $api_key        = $config->{api_key};
my $api_url        = "https://ws.detectlanguage.com/0.2/detect";
my $languages_file = 'languages.csv';
my %languages;
my %response_data;
my $language_detected_code;
my $is_reliable;
my $confidence;

my $ua = LWP::UserAgent->new();
$ua->default_header( 'Authorization' => "Bearer " . $api_key );
$ua->default_header( 'Content-Type'  => 'application/json' );
my $response = $ua->post( $api_url, { q => $text } );

open( my $data, '<', $languages_file )
    or die "Could not open '$languages_file' $!\n";
while ( my $line = <$data> ) {
    chomp $line;
    my ( $code, $language ) = split ",", $line;
    $languages{$code} = $language;
}

%response_data          = %{ decode_json( $response->decoded_content ) };
$language_detected_code = $response_data{"data"}{detections}[0]{language};
$is_reliable            = $response_data{"data"}{detections}[0]{isReliable};
$confidence             = $response_data{"data"}{detections}[0]{confidence};

print "The following text has been analysed: '$text'\n";
print "It was found to be written in $languages{$language_detected_code}.  ";
print "The confidence value was $confidence and this is thought to be ";
if ( $is_reliable eq "false" ) {
    print
        "unreliable, you may wish to pass more text to get a more reliable identification.\n";
}
else {
    print "reliable.\n";
}
