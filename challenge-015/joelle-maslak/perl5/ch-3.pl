#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use Mojo::UserAgent;
use Path::Tiny;
use Perl6::Slurp;

MAIN: {
    my $configfile = path( $ENV{HOME} // "", ".languageapi" )->stringify();
    my $url        = 'https://ws.detectlanguage.com/0.2/detect';
    GetOptions(
        "url=s"         => \$url,
        "config-file=s" => \$configfile,
    );

    if ( @ARGV != 0 ) { die("Unknown parameter"); }

    my $apikey = get_api_key($configfile);

    my $input = '';
    while (<stdin>) { $input .= $_ }

    my $info = get_language($input, $apikey, $url);
    my $result = $info->{data}{detections}[0];
    say "Language: ", $result->{language};
    say "Is reliable: ", $result->{isReliable} ? "Yes" : "No";
    say "Confidence: ", $result->{confidence};
}

sub get_api_key($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

# Usage:
#   text   = Text to look up
#   apikey = Your API key
#   url    = URL
#
sub get_language($text, $apikey, $url) {
    my $ua = Mojo::UserAgent->new();
    $ua->max_redirects(16);
    $ua->once(
        start => sub ( $ua, $tx ) {
            $tx->req->headers->header( 'Authorization' => "Bearer " . $apikey );
        }
    );

    my $tx = $ua->post($url, json => { q => $text } );
    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        return $json;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{error}{message};
}

