#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;

sub MAIN(
    Str:D :$url = 'https://www.poemist.com/api/v1/randompoems',
) {
    my $poem = get-poem(:$url);
    say $poem[0]<title>;
    say "By " ~ $poem[0]<poet><name>;
    say "";
    say $poem[0]<content>;
}

sub get-poem(Str:D :$url) {
    my $client = Cro::HTTP::Client.new();

    my $resp = await $client.get($url);
    my $json = await $resp.body;

    return $json;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint";
        }
    }
}


