#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

use Carp;
use Data::Dumper;
use Furl;
use URI::Escape;
use JSON::MaybeXS;
use HTTP::Request;

use constant BASE_URL => 'http://geodb-free-service.wirefreethought.com/v1/geo/cities';

MAIN: {
    my $keywords = $ARGV[0] || croak q|Missing city!|;
    my $cities = _find_cities($keywords);

    if (@{$cities}) {
        foreach (@{$cities}) {
            say sprintf 'Country: %-15s City: %-15s Time: %-15s',
                $_->{country}, $_->{name}, _find_city_time($_->{id})
        }
    } else {
        say 'No city found!';
    }
}

sub _find_cities {
    my ($keywords) = @_;

    my $endpoint = BASE_URL;
    $endpoint .= '?namePrefix=' . uri_escape($keywords);
    $endpoint .= '&limit=5&offset=0&hateoasMode=false';

    return _request('get', $endpoint);
}

sub _find_city_time {
    my ($city_id) = @_;

    my $endpoint = BASE_URL;
    $endpoint .= qq|/$city_id/time|;

    return _request('get', $endpoint);
}

sub _request {
    my ($method, $endpoint) = @_;

    my $ua = Furl->new(
        agent   => 'Perl Weekly Challenge -(https://perlweeklychallenge.org)',
        timeout => 10,
    );

    my $request = HTTP::Request->new(uc $method => $endpoint);
    my $response = $ua->request($request);
    return decode_json($response->content)->{data} if ($response->is_success);

    croak $response->status_line;
}

1;

__END__

$ perl ch-3.pl kuala
Country: Brunei          City: Kuala Belait    Time: 22:54:01.058183
Country: Indonesia       City: Kuala Tungkal   Time: 21:54:01.637034
Country: Indonesia       City: Kualakapuas     Time: 21:54:02.200661
Country: Malaysia        City: Kuala Kangsar   Time: 22:54:02.769849
Country: Malaysia        City: Kuala Lumpur    Time: 22:54:03.33483

$ perl ch-3.pl xxx
No city found!
