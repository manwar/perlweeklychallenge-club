#!/usr/bin/env perl6
use v6;

# Not having details of whcih part of the API to implement, this script
# looks up all the glosses for a given word (in the same language as the
# word itself)

use Cro::HTTP::Client;
use URI::Encode;

sub MAIN(
    Str:D $word,
    Str:D :$language?    = 'EN',
    Str:D :$config-file? = $*HOME.add(".babelnet").Str,
    Str:D :$base-url     = 'https://babelnet.io/',
) {
    my @synsets = get-synsets(:$config-file, :$base-url, :$word, :$language).flat.map( { $_<id> } );
    say "No results for word" unless @synsets.elems;

    for ^(@synsets.elems) -> $i {
        say "" if $i;
        say "Result # {$i.succ}";

        my $json = get-info(:$config-file, :$base-url, :$language, :synset( @synsets[$i] ));
        if $json<glosses>.elems {
            say " * " ~ $json<glosses>.map( { $_<gloss> } ).join("\n * ");
        } else {
            say " No glosses found";
        }
    }
}

sub get-client-secret(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines[0];
}

sub get-synsets(
    Str:D :$word,
    Str:D :$language,
    Str:D :$base-url,
    Str:D :$config-file,
) {
    my $secret = get-client-secret($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri => $base-url,
        :!persistent,
    );

    my $resp = await $client.get(
        "v5/getSynsetIds?lemma={ uri_encode_component($word) }" ~
            "&searchLang={ uri_encode_component($language) }" ~
            "&key={ uri_encode_component($secret) }",
    );
    my $json = await $resp.body;
  
    if $json ~~ Array {
        return $json;
    } else {
        die "Error from API endpoint: $json<message>";
    }

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

sub get-info(
    Str:D :$synset,
    Str:D :$language,
    Str:D :$base-url,
    Str:D :$config-file,
) {
    my $secret = get-client-secret($config-file);
    
    my $client = Cro::HTTP::Client.new(
        base-uri => $base-url,
        :!persistent,
    );

    my $resp = await $client.get(
        "v5/getSynset?id={ uri_encode_component($synset) }" ~
            "&targetLang={ uri_encode_component($language) }" ~
            "&key={ uri_encode_component($secret) }",
    );
    my $json = await $resp.body;
    return $json;

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

