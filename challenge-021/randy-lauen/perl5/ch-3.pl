#!/usr/bin/env perl

use v5.28;
use strict;
use warnings;

=head1 SYNOPSIS

Task: Write a script to use BC Gov News API.

This script prints out the top and feature post headlines.

Example output:
    $ perl ch-3.pl
    topPostKey
    * News Release: Third urgent and primary care centre opens in Greater Vancouver
    * Backgrounder: North Vancouver UPCC

    featurePostKey
    * News Release: Province seeks feedback to ban, reduce, recycle more plastics

=cut

use HTTP::API::Client;

my $agent = HTTP::API::Client->new(
    base_url         => URI->new('https://news.api.gov.bc.ca'),
    pre_defined_data => { 'api-version' => '1.0' },
);

$agent->get('/api/Home');
my $homeInfo = $agent->json_response();

foreach my $key (qw( topPostKey featurePostKey )) {
    $agent->get("/api/Posts/$homeInfo->{$key}");
    my $postInfo = $agent->json_response();

    say $key;
    foreach my $document ( $postInfo->{documents}->@* ) {
        say "* $document->{pageTitle}: $document->{headline}";
    }
    say '';
}
