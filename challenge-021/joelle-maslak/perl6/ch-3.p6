#!/usr/bin/env perl6
use v6;

# Gets the name of the most recent newsletter

use Cro::HTTP::Client;
use URI::Encode;

sub MAIN(
    Str:D :$base-url = 'https://news.api.gov.bc.ca/api/',
    Str:D :$newsletter-key = 'bc-stats-infoline',
) {
    my $news = get-latest-newsletter(:$base-url, :$newsletter-key);

    say $news;
}

sub get-latest-newsletter(Str:D :$base-url, Str:D :$newsletter-key is copy) {
    $newsletter-key = uri_encode_component($newsletter-key);

    my $client = Cro::HTTP::Client.new( :base-uri($base-url) );

    my $resp = await $client.get("Newsletters/$newsletter-key?api-version=1.0");
    my $json = await $resp.body;

    die "No newsletters for key found" if $json.elems == 0;
    my $edition = uri_encode_component($json[0]<editions>[0]<key>);

    $resp = await $client.get("Newsletters/$newsletter-key/Editions/$edition?api-version=1.0");
    $json = await $resp.body;

    return $json<name>;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint";
        }
    }
}


