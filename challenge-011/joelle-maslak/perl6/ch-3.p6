#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;
use URI::Encode;

multi sub MAIN(
    UInt:D :$city-id,
    Str:D  :$config-file? = $*HOME.add(".openweathermap").Str,
) {
    get-weather(:$city-id, :$config-file);
}

multi sub MAIN(
    Str:D :$city-name,
    Str:D :$config-file? = $*HOME.add(".openweathermap").Str,
) {
    get-weather(:$city-name, :$config-file);
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines[0];
}

# Usage:
#   :$city-id     = Numeric City ID
#   :$city-name   = <city name> or <city name>,<country-code> 
#   :$config-file = Name of config file to use
#
sub get-weather(
    Int   :$city-id,
    Str   :$city-name,
    Str:D :$config-file,
) {
    my $api-key = get-api-key($config-file);
    my $url = "https://api.openweathermap.org/data/2.5/";
    
    my $querystring = "";
    if $city-id.defined {
        $querystring ~= "id=$city-id";
    } else {
        $querystring ~= "q={uri_encode_component($city-name)}";
    }
    $querystring ~= "&appid={uri_encode_component($api-key)}";

    my $client = Cro::HTTP::Client.new( base-uri => $url );
    my $resp = await $client.get("weather?$querystring");
    my $json = await $resp.body;

    say "Weather for {$json<name>}, {$json<sys><country>} (ID={$json<id>}):";
    say "  " ~ $json<weather>.map( { $^a<description> } ).join("; ");
    say "  Temp: {k2c($json<main><temp>).fmt("%.0f")}C / {k2f($json<main><temp>).fmt("%.0f")}F";
    
    return;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

sub k2c($k) {
    return $k - 273.15;
}

sub k2f($k) {
    return k2c($k) * 9/5 + 32;
}

