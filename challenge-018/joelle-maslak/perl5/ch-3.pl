#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Not having details of which part of the API to implement, this script
# looks up all the glosses for a given word (in the same language as the
# word itself)

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
    binmode STDOUT, ':utf8';

    my $configfile = path( $ENV{HOME} // "", ".babelnet" )->stringify();
    my $baseurl    = 'https://babelnet.io/';
    my $language   = 'EN';
    GetOptions(
        "base-url=s"    => \$baseurl,
        "config-file=s" => \$configfile,
        "language=s"    => \$language,
    );
    die "Must provide word to look up" if @ARGV < 1;
    my $word = shift(@ARGV);

    if ( @ARGV != 0 ) { die("Unknown parameter"); }

    my $secret = get_client_secret($configfile);
    my (@synsets) = get_synsets( $secret, $word, $language, $baseurl );
    say "No results for word" unless @synsets;

    for my $i ( 0 .. ( @synsets - 1 ) ) {
        say "" if $i;
        say "Result # " . ( $i + 1 );

        my $json = get_info( $secret, $synsets[$i]->{id}, $language, $baseurl );
        if ( $json->{glosses}->@* ) {
            say " * " . join( "\n * ", map { $_->{gloss} } $json->{glosses}->@* );
        } else {
            say " No glosses found";
        }
    }
}

sub get_client_secret($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

sub get_synsets ( $secret, $word, $language, $baseurl ) {
    my $ua = Mojo::UserAgent->new();
    $ua->max_redirects(16);

    my $tx = $ua->get(
            "${baseurl}v5/getSynsetIds?lemma="
          . url_escape($word)
          . "&searchLang="
          . url_escape($language) . "&key="
          . url_escape($secret),
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        if ( ref($json) eq 'ARRAY' ) {
            return $json->@*;
        } else {
            die "Error from API endpoint " . $json->{message};
        }
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{message};
}

sub get_info ( $secret, $synset, $language, $baseurl ) {
    my $ua = Mojo::UserAgent->new();
    $ua->max_redirects(16);

    my $tx = $ua->get(
            "${baseurl}v5/getSynset?id="
          . url_escape($synset)
          . "&targetLang="
          . url_escape($language) . "&key="
          . url_escape($secret),
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        return $tx->result->json;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{message};
}

