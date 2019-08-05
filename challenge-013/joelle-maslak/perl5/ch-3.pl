#!/usr/bin/env perl
use v5.22;
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

MAIN: {
    my $configfile = path( $ENV{HOME} // "", ".rapidapi" )->stringify();
    my $urlbase    = 'https://wordsapiv1.p.mashape.com/words/';
    GetOptions(
        "urlbase=s"     => \$urlbase,
        "config-file=s" => \$configfile,
    );
    if ( @ARGV != 1 ) { die("Must specify one word to look up"); }

    my $apikey = get_api_key($configfile);

    my ($info) = get_info(
        apikey  => $apikey,
        urlbase => $urlbase,
        word    => $ARGV[0],
    );
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
#   word      = Word to look up
#
sub get_info(%args) {
    my $url = $args{urlbase} . url_escape( $args{word} );

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
        if ( exists( $json->{results} ) ) {
            my $pretty = JSON::PP->new->utf8->pretty->indent->encode($json);
            say $pretty;
        } else {
            say "Could not fetch info from API";
        }
        return;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{message};
}

