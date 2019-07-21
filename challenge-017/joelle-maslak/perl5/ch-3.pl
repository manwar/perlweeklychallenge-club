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
    binmode STDOUT, ':utf8';

    my $configfile = path( $ENV{HOME} // "", ".bhagavad-gita" )->stringify();
    my $baseurl    = 'https://bhagavadgita.io/';
    GetOptions(
        "base-url=s"    => \$baseurl,
        "config-file=s" => \$configfile,
    );
    die "Must provide chapter and verse" if @ARGV < 2;
    my $chapter = 0+shift(@ARGV);
    my $verse   = 0+shift(@ARGV);

    if ( @ARGV != 0 ) { die("Unknown parameter"); }

    my $id = get_client_id($configfile);
    my $secret = get_client_secret($configfile);
    my $token = get_token($id, $secret, $baseurl);
    say get_verse($token, $chapter, $verse, $baseurl);
}

sub get_client_id($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of two lines" if @lines != 2;
    chomp $lines[0];
    return $lines[0];
}

sub get_client_secret($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of two lines" if @lines != 2;
    chomp $lines[1];
    return $lines[1];
}

sub get_token($id, $secret, $baseurl) {
    my $ua = Mojo::UserAgent->new();
    $ua->max_redirects(16);

    my $tx = $ua->post(
        "${baseurl}auth/oauth/token",
        form => {
            client_id => $id,
            client_secret => $secret,
            grant_type => 'client_credentials',
            scope => 'verse chapter',
        },
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        return $json->{access_token};
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{error};
}

sub get_verse($token, $chapter, $verse, $baseurl) {
    my $ua = Mojo::UserAgent->new();
    $ua->once(
        start => sub ( $ua, $tx ) {
            $tx->req->headers->header( 'Authorization' => "Bearer " . $token);
        }
    );
    $ua->max_redirects(16);

    my $tx = $ua->get(
        "${baseurl}api/v1/chapters/$chapter/verses/$verse",
    );

    if ( ( $tx->result->code >= 200 ) && ( $tx->result->code <= 299 ) ) {
        my $json = $tx->result->json;
        return $json->{text};
    }

    my $body = $tx->result->json;
    die "Error from API endpoint: " . $body->{message};
}

