#!/usr/bin/env perl6
use v6;

# Not having details of whcih part of the API to implement, this script
# looks up the top book on the selected list (defaults to
# hardcover-nonfiction)

use Cro::HTTP::Client;
use URI::Encode;

sub MAIN(
    Str:D $list          = 'hardcover-nonfiction',
    Str:D :$config-file? = $*HOME.add(".nyt").Str,
    Str:D :$base-url     = 'https://api.nytimes.com/svc/books/v3/';
) {
    my $books = get-books(:$config-file, :$base-url, :$list);
    die "No results.  Are you using a valid list name?" if $books<num_results> == 0;
    
    my $top = $books<results>[0];
    say "Top book on $list: $top<book_details>[0]<title>";
}

sub get-client-secret(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines[0];
}

sub get-books(
    Str:D :$list,
    Str:D :$base-url,
    Str:D :$config-file,
) {
    my $secret = get-client-secret($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri => $base-url,
    );

    my $resp = await $client.get(
        "lists.json?list={ uri_encode_component($list) }" ~
            "&api-key={ uri_encode_component($secret) }",
    );
    my $json = await $resp.body;
    return $json;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<fault><faultstring>";
        }
    }
}

