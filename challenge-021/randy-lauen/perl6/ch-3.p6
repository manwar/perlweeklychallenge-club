#!/usr/bin/env perl6

=begin SYNOPSIS

Task: Write a script to use BC Gov News API.

This script prints out the top and feature post headlines.

Example output:

    $ perl6 ch-3.p6
    topPostKey
    * News Release: Third urgent and primary care centre opens in Greater Vancouver
    * Backgrounder: North Vancouver UPCC

    featurePostKey
    * News Release: Province seeks feedback to ban, reduce, recycle more plastics

=end SYNOPSIS

use Cro::HTTP::Client;
use URI::Encode;

class ApiClient {
    has %.params;
    has $.base-uri;
    has $!client = Cro::HTTP::Client.new(
        :http('1.1'),
        :base-uri( $!base-uri )
        :headers( [ Accept => 'application/json' ] ),
    );

    method get( $path ) {
        return self!get-json( "$path?" ~ %!params.pairs.map( { .key ~ '=' ~ .value } ).join('&') );
    }

    method !get-json( $uri ) {
        my $encoded = uri_encode( $uri );
        my $response = await $!client.get( $encoded );
        return await $response.body;
    }
}


sub MAIN() {
    my $client = ApiClient.new(
        base-uri => 'https://news.api.gov.bc.ca',
        params   => %( :api-version('1.0') ),
    );
    my %homeInfo = $client.get( '/api/Home' );

    for <topPostKey featurePostKey> -> $key {
        my %postInfo = $client.get( "/api/Posts/%homeInfo{$key}" );
        say $key;

        for %postInfo<documents>.flat -> $doc {
            say "* $doc<pageTitle>: $doc<headline>";
        }
        say '';
    }
}
