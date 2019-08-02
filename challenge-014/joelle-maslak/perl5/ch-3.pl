#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use JSON::PP;
use Mojo::Util qw(url_escape);
use Mojo::UserAgent;
use Path::Tiny;
use Perl6::Slurp;
use Term::Choose qw(choose);

MAIN: {
    my $configfile = path( $ENV{HOME} // "", ".rapidapi" )->stringify();
    my $url_time   = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities/_CITY_/time';
    my $url_lookup = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=_CITY_';
    GetOptions(
        "url-time=s"    => \$url_time,
        "url-lookup=s"  => \$url_lookup,
        "config-file=s" => \$configfile,
    );

    if ( @ARGV != 1 ) { die("Must specify one city to look up"); }
    my $city = $ARGV[0];

    my $apikey = get_api_key($configfile);

    if ($city =~ m/^ [0-9]+ \z/msxx) {
        display_time($city, $apikey, $url_time);
    } else {
        my ($info) = get_city(
            apikey  => $apikey,
            urlbase => $url_lookup,
            city    => $ARGV[0],
        );

        if (scalar($info) == 0) {
            say "No results";
        } elsif (scalar($info) == 1) {
            display_time($info->[0]{id}, $apikey, $url_time);
        } else {
            my %tableinfo;
            my (@table);
            for my $row ($info->@*) {
                my $line = "(" . $row->{id} . ") " . $row->{city} . ", " .
                    $row->{regionCode} . ", " . $row->{countryCode};
                push @table, $line;
                $tableinfo{$line} = $row->{id};
            }
            my $selected = choose( \@table );
            if (! defined $selected ) {
                say "No city selected";
                exit;
            }
            display_time($tableinfo{$selected}, $apikey, $url_time);
        }
    }
}

sub display_time($city_id, $apikey, $url) {
    my $time = get_time(
        apikey  => $apikey,
        urlbase => $url,
        city_id => $city_id,
    );
    if (defined $time) {
        say "Current time: $time";
    } else {
        say "No results";
    }
}

sub get_api_key($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

# Usage:
#   apikey    = Your API key
#   urlbase   = Base URL
#   city      = City ID to look up
#
sub get_city(%args) {
    my $url = $args{urlbase};
    $url =~ s/_CITY_/url_escape( $args{city} )/eg;

    my $ua = Mojo::UserAgent->new();
    $ua->max_redirects(16);
    $ua->once(
        start => sub ( $ua, $tx ) {
            $tx->req->headers->header( 'X-Mashape-Key' => $args{apikey} );
        }
    );

    my $tx = $ua->get($url);
    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        if ( exists( $json->{data} ) ) {
            return $json->{data};
        } else {
            say "Could not fetch info from API";
        }
        return;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{errors}[0]{message};
}

# Usage:
#   apikey    = Your API key
#   urlbase   = Base URL
#   city_id   = City ID to look up
#
sub get_time(%args) {
    my $url = $args{urlbase};
    $url =~ s/_CITY_/url_escape( $args{city_id} )/eg;

    my $ua = Mojo::UserAgent->new();
    $ua->max_redirects(16);
    $ua->once(
        start => sub ( $ua, $tx ) {
            $tx->req->headers->header( 'X-Mashape-Key' => $args{apikey} );
        }
    );

    my $tx = $ua->get($url);
    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        if ( exists( $json->{data} ) ) {
            return $json->{data};
        } else {
            say "Could not fetch info from API";
        }
        return;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{errors}[0]{message};
}

