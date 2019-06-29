#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;
use Terminal::Table;
use URI::Encode;

multi sub MAIN(
    Int   $city-id,
    Str:D :$config-file? = $*HOME.add(".rapidapi").Str,
    Str:D :$url-time     = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities/_CITY_/time',
) {
    my $info = get-time(:$city-id, :url($url-time), :$config-file);
    if $info.defined {
        say "Current time: $info";
    } else {
        say "No results";
    }
}

multi sub MAIN(
    Str:D $city,
    Str:D :$config-file? = $*HOME.add(".rapidapi").Str,
    Str:D :$url-time     = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities/_CITY_/time',
    Str:D :$url-lookup   = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=_CITY_',
) {
    my $lookup = get-city(:$city, :url($url-lookup), :$config-file);
    if $lookup<data>.elems == 0 {
        die("City not found");
    } elsif $lookup<data>.elems == 1 {
        MAIN($lookup<data>[0]<id>, :$config-file, :$url-time);
    } else {
        say "There is more than one city that matches. Please use the City ID";
        say "";
        
        my @table;
        @table.push: ["City ID", "City", "Region", "Country"];
        for @($lookup<data>) -> $row {
            @table.push: [
                $row<id>.Str,
                $row<city>,
                $row<regionCode>,
                $row<countryCode>,
            ];
        }
        print-table(@table);
    }
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines.first;
}

# Usage:
#   :$city-id     = City ID to look up
#   :$url         = base URL
#   :$config-file = Name of config file to use
#
sub get-city (
    Str:D :$city,
    Str:D :$url,
    Str:D :$config-file,
) {
    my $api-key = get-api-key($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri => $url,
        headers  => [ X-Mashape-Key => $api-key ],
    );

    my $fetch-url = S:g/_CITY_/{uri_encode_component($city)}/ given $url;

    my $resp = await $client.get($fetch-url);
    my $json = await $resp.body;

    if $json<data>:exists {
        return $json<data>;
    } else {
        return;
    }

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

# Usage:
#   :$city-id     = City ID to look up
#   :$url         = base URL
#   :$config-file = Name of config file to use
#
sub get-time (
    Int:D() :$city-id,
    Str:D   :$url,
    Str:D   :$config-file,
) {
    my $api-key = get-api-key($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri => $url,
        headers  => [ X-Mashape-Key => $api-key ],
    );

    my $fetch-url = S:g/_CITY_/{uri_encode_component($city-id.Str)}/ given $url;

    my $resp = await $client.get($fetch-url);
    my $json = await $resp.body;

    if $json<data>:exists {
        return $json<data>;
    } else {
        return;
    }

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            $*ERR.say("Error from API endpoint: $body<errors>[0]<message>");
            exit;
        }
    }
}

