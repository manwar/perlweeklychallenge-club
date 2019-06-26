#!/usr/bin/env perl6
use v6;

use Cro::HTTP::Client;
use URI::Encode;

sub MAIN(
    Str:D $word,
    Str:D :$config-file? = $*HOME.add(".rapidapi").Str,
    Str:D :$urlbase?     = 'https://wordsapiv1.p.mashape.com/words/';
) {
    my $info = get-word(:$word, :$urlbase, :$config-file);
    if $info ne '' {
        pretty-print($info);
    } else {
        say "No results";
    }
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of one line" if @lines.elems ≠ 1;

    return @lines.first;
}

# Usage:
#   :$word        = word to look up
#   :$urlbase     = base URL
#   :$config-file = Name of config file to use
#
sub get-word(
    Str:D :$word,
    Str:D :$urlbase,
    Str:D :$config-file,
) {
    my $api-key = get-api-key($config-file);
    my $url     = $urlbase;
    
    my $client = Cro::HTTP::Client.new(
        base-uri => $url,
        headers  => [ X-Mashape-Key => $api-key ],
    );
    my $resp = await $client.get(uri_encode_component($word));
    my $json = await $resp.body;

    if $json<results>:exists {
        return $json;
    } else {
        return;
    }

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

multi sub pretty-print(Array $structure, $indent = "", $continuation = False) {
    say "" if $continuation;
    my $cnt = 0;
    for @$structure -> $item {
        print "{$indent}[{$cnt.fmt("%2d")}] ";
        pretty-print($item, "$indent     ", True);
        $cnt++;
    }
}
multi sub pretty-print(Hash $structure, $indent = "", $continuation = False) {
    say "" if $continuation;
    my $max = ($structure.keys.map( { cannonical-key($_) } )».chars).max;
    for $structure.keys.sort -> $key {
        print "$indent";
        print "{ cannonical-key($key) }: ".fmt("%-{$max+2}s");
        pretty-print($structure{$key}, "{$indent}{' ' x ($max + 2)}", True);
    }
}
multi sub pretty-print(Str() $structure, $indent = "", $continuation = False) {
    if $continuation {
        say "$structure";
    } else {
        say "$indent$structure";
    }
}

sub cannonical-key($key) {
    my %cannonical =
        definition    => "Definition",
        partOfSpeech  => "Part of Speech",
        typeOf        => "Type of (less speicific)",
        hasTypes      => "Has Types",
        partOf        => "Part of (thing)",
        hasParts      => "Has Parts",
        examples      => "Examples",
        syllables     => "Syllables",
        count         => "Count",
        list          => "List",
        word          => "Word",
        frquency      => "Frequency",
        inCategory    => "In Category",
        pronunciation => "Pronunciation",
        results       => "Results",
        synonyms      => "Synonyms",
    ;

    return %cannonical{$key} // $key;
}
