#!/usr/bin/env perl
#
# Write a script to use Random Poems API. This is the easiset API, I have come
# across so far. You don’t need API key for this. They have only route to work
# with (GET).
#
# (https://www.poemist.com/api/v1/randompoems)
################################################################################

use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';
use autodie;

use HTTP::Request;
use LWP::UserAgent;
use JSON qw<decode_json>;
use Time::HiRes qw<sleep>;

my $ua = LWP::UserAgent->new();
$ua->agent("gramos's script for perlweeklychallenge.org");

my $uri = 'https://www.poemist.com/api/v1/randompoems';
my $resp = $ua->request(HTTP::Request->new('GET', $uri));
my $content = decode_json($resp->content);
my $poem = $content->[0];
my $poet = $poem->{'poet'};

$|++;
sub typewrite {
    my $text = shift;
    foreach my $i (0 .. length($text) - 1) {
        my $char = substr($text, $i, 1);
        print $char;

        my $sleep =
            $char eq ',' ? 0.2 :
            (grep { $_ eq $char } qw<- : ( )>) ? 0.3 :
            $char eq ';' ? 0.4 :
            $char eq '.' ? 0.5 :
            (grep { $_ eq $char } qw<! ?>) ? 0.6 :
            $char eq "\n" ? 0.7 :
            0.06;
        sleep($sleep);
    }
}

typewrite sprintf "%s", $poem->{'title'};
sleep(0.2);
typewrite sprintf "\nby %s\n\n", $poet->{'name'};
printf "(%s)", $poem->{'url'};
typewrite(sprintf "\n\n%s\n", $poem->{'content'});
