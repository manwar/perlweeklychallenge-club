#! /opt/local/bin/perl
#
#       poem_api_2.pl
#
#       access the random poem api at https://www.poemist.com/api/v1/randompoems
#       decode the JSON and print to STDOUT
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use LWP::UserAgent;
use JSON::XS qw( decode_json );

use warnings;
use strict;
use diagnostics;
use feature ":5.26";

binmode STDOUT, ':utf8';

## ## ## ## ## MAIN

## Create a user agent object
my $ua = LWP::UserAgent->new(
    ssl_opts => {
        verify_hostname => 1,
    }
);
$ua->agent("random_poem_api/1.0");

## Create a request
my $req = HTTP::Request->new( GET => 'https://www.poemist.com/api/v1/randompoems' );
$req->header( 'Accept' => 'application/json');

## Pass request to the user agent and get a response back
my $res = $ua->request($req);

## Check the outcome of the response
if (! $res->is_success) {
    die "there was bad response: ", $res->status_line, "\n";
}

## decode the JSON data
my $data = decode_json $res->content;

## the decoded data is an array ref of hash refs, each with keys:
##      {content}
##      {title}
##      {url}
##      {poet}->{name}
##      {poet}->{url}

## output to STDOUT
foreach my $poem ( $data->@* ) {
    ## there are weird database glitches that need to be worked around
    ## rarely some poems appear to have no content, or no title. Some Arabic poems in particular.
    ## Rather than fail we'll simply silently skip these.
    next if ( ! $poem->{title} || ! $poem->{poet}->{name} || ! $poem->{content} || ! $poem->{url}  );

    say $poem->{title};
    say "by $poem->{poet}->{name}";
    say "";
    say $poem->{content};
    say "";
    say "url: ", $poem->{url};
    say "\n----------\n";
}


