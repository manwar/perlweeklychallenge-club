#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;
use URI::Encode;

sub MAIN(
    Str:D $word,
    Str:D :$config-file? = $*HOME.add(".stands4u").Str,
    Str:D :$urlbase?     = 'http://www.stands4.com';
) {
    say "Synonyms: " ~ get-synonyms(:$word, :$urlbase, :$config-file);
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of two lines" if @lines.elems ≠ 2;

    return @lines[1];
}

sub get-uid(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of two lines" if @lines.elems ≠ 2;

    return @lines[0];
}

# Usage:
#   :$word        = word to look up
#   :$urlbase     = base URL
#   :$config-file = Name of config file to use
#
sub get-synonyms(
    Str:D :$word,
    Str:D :$urlbase,
    Str:D :$config-file,
) {
    my $api-key = get-api-key($config-file);
    my $uid     = get-uid\   ($config-file);
    my $url     = $urlbase;
    
    my $querystring = "";

    $querystring ~= "uid={uri_encode_component($uid)}";
    $querystring ~= "&tokenid={uri_encode_component($api-key)}";
    $querystring ~= "&word={uri_encode_component($word)}";
    $querystring ~= "&format=json";

    my $client = Cro::HTTP::Client.new( base-uri => $url );
    my $resp = await $client.get("/services/v2/syno.php?$querystring");
    my $json = await $resp.body;

    return $json<results><result><synonyms>;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<error>";
        }
    }
}

