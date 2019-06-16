#!/usr/bin/env perl
use v5.22;
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
    my $configfile = path( $ENV{HOME} // "", ".stands4u" )->stringify();
    my $urlbase    = 'http://www.stands4.com';
    GetOptions(
        "urlbase=s"     => \$urlbase,
        "config-file=s" => \$configfile,
    );
    if ( @ARGV != 1 ) { die("Must specify one word to look up"); }

    my $uid    = get_uid($configfile);
    my $apikey = get_api_key($configfile);

    my (@syns) = get_synonyms(
        uid     => $uid,
        apikey  => $apikey,
        urlbase => $urlbase,
        word    => $ARGV[0],
    );
}

sub get_uid($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 2;
    chomp $lines[0];
    return $lines[0];
}

sub get_api_key($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 2;
    chomp $lines[1];
    return $lines[1];
}

# Usage:
#   uid       = Your User ID
#   apikey    = Your API key
#   urlbase   = Base URL
#   word      = Word to look up
#
sub get_synonyms(%args) {
    my $url = $args{urlbase} . '/services/v2/syno.php?';

    $url .= 'uid=' . url_escape( $args{uid} );
    $url .= '&tokenid=' . url_escape( $args{apikey} );
    $url .= '&word=' . url_escape( $args{word} );
    $url .= '&format=json';

    my $ua = Mojo::UserAgent->new();

    my $tx = $ua->get($url);
    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        say "Synonyms: " . $json->{results}{result}{synonyms};
        return;
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{error};
}

