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

MAIN: {
    my $url = 'https://www.poemist.com/api/v1/randompoems';
    GetOptions( "url=s" => \$url );
    if ( @ARGV > 0 ) { die("Invalid parameter") }

    my $poem = get_poem($url);
    say $poem->{title};
    say "By " . $poem->{poet}{name};
    say "";
    say $poem->{content};
}

sub get_poem( $url ) {
    my $ua = Mojo::UserAgent->new();

    my $tx = $ua->get($url);

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $body = $tx->result->json;
        return $body->[0];
    } else {
        die "Error from API endpoint";
    }
}

