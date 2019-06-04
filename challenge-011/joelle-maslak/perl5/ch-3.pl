#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use Mojo::Util qw(url_escape);
use Mojo::UserAgent;
use Path::Tiny;
use Perl6::Slurp;

MAIN: {
    my $configfile = path( $ENV{HOME} // "", ".openweathermap" )->stringify();
    my ( $city_name, $city_id );
    GetOptions(
        "city-name=s"   => \$city_name,
        "city-id=i"     => \$city_id,
        "config-file=s" => \$configfile,
    );

    if ( ( !defined($city_name) ) && ( !defined($city_id) ) ) {
        die("Must specify --city_name=<city> or --city_id=<id>");
    }

    my $apikey = get_api_key($configfile);

    get_weather(
        apikey    => $apikey,
        city_name => $city_name,
        city_id   => $city_id,
    );
}

sub get_api_key($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

# Usage:
#   apikey    = Your Sendgrid API key
#   city_name = Optional <city name> or <city name>,<country-code>
#   city_id   = Numeric City ID
#
sub get_weather(%args) {
    my $url = "https://api.openweathermap.org/data/2.5/weather?";

    if ( defined( $args{city_id} ) ) {
        $url .= "id=" . $args{city_id};
    } else {
        $url .= "q=" . url_escape( $args{city_name} );
    }
    $url .= "&appid=" . url_escape( $args{apikey} );

    my $ua = Mojo::UserAgent->new();

    my $tx = $ua->get($url);
    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        say "Wather for "
          . $json->{name} . ", "
          . $json->{sys}{country} . " " . "(ID="
          . $json->{id} . ")";
        say "  " . join( "; ", map { $_->{description} } $json->{weather}->@* );
        say sprintf( "  Temp: %.0fC / %.0fF", k2c( $json->{main}{temp} ),
            k2f( $json->{main}{temp} ) );
        return;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{message};
}

sub k2c($k) {
    return $k - 273.15;
}

sub k2f($k) {
    return k2c($k) * 9/5 + 32;
}

