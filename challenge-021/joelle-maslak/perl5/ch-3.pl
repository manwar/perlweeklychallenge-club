#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Gets the name of the most recent newsletter

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use Mojo::UserAgent;
use Mojo::Util qw(url_escape);
use Path::Tiny;
use Perl6::Slurp;

MAIN: {
    my $baseurl        = 'https://news.api.gov.bc.ca/api/';
    my $newsletter_key = 'bc-stats-infoline';
    GetOptions(
        "base-url=s"       => \$baseurl,
        "newsletter-key=s" => \$newsletter_key,
    );
    if ( @ARGV > 0 ) { die("Invalid parameter") }

    say get_latest_newsletter( $baseurl, $newsletter_key );
}

sub get_latest_newsletter ( $baseurl, $newsletter_key ) {
    my $ua = Mojo::UserAgent->new();

    my $tx =
      $ua->get( "${baseurl}Newsletters/" . url_escape($newsletter_key) . "?api-version=1.0", );

    my $edition;
    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $body = $tx->result->json;
        die "No newsletters for key found" unless exists $body->[0];
        $edition = $body->[0]{editions}[0]{key};
    } else {
        die "Error from API endpoint";
    }

    $tx = $ua->get(
            "${baseurl}Newsletters/"
          . url_escape($newsletter_key)
          . "/Editions/"
          . url_escape($edition)
          . "?api-version=1.0",
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $body = $tx->result->json;
        return $body->{name};
    } else {
        die "Error from API endpoint";
    }
}

