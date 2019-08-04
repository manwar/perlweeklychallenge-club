#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Not having details of which part of the API to implement, this script
# looks up all the top book on the selectd list (defaults to
# hardcover-nonfiction)

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
    my $configfile = path( $ENV{HOME} // "", ".nyt" )->stringify();
    my $baseurl    = 'https://api.nytimes.com/svc/books/v3/';
    GetOptions(
        "base-url=s"    => \$baseurl,
        "config-file=s" => \$configfile,
    );
    my $list = shift(@ARGV) // 'hardcover-nonfiction';

    if ( @ARGV != 0 ) { die("Unknown parameter"); }

    my $secret = get_client_secret($configfile);
    my $books  = get_books( $secret, $list, $baseurl );

    die("No results, are you using a valid list name?") if $books->{num_results} == 0;

    my $top = $books->{results}[0];
    say "Top book on $list: " . $top->{book_details}[0]{title};
}

sub get_client_secret($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

sub get_books ( $secret, $list, $baseurl ) {
    my $ua = Mojo::UserAgent->new();

    my $tx = $ua->get(
        "${baseurl}lists.json?list=" . url_escape($list) . "&api-key=" . url_escape($secret),
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        return $tx->result->json;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{fault}{faultstring};
}

