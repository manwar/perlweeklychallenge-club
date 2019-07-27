#!/usr/bin/env perl6

=begin SYNOPSIS

Challenge 3: Write a script to use BabelNet API.

This script attempts to output a random "Six degrees of BabelNet" feature
for a given word or phrase.

Usage:
    ./ch-3.p6 --key=KEY --word='Larry Wall'

Example output:
    $ perl6 ch-3.p6 --key=KEY --word='Larry Wall'
    1. Initial: Larry_Wall (bn:00992148n) => Larry Wall is a computer programmer and author.
    2. related: Perl_module (bn:03320928n) => A Perl module is a discrete component of software for the Perl programming language.
    3. related: class_(computer_programming) (bn:03608262n) => In object-oriented programming, a class is an extensible program-code-template for creating objects, providing initial values for state and implementations of behavior.
    4. related: word_(computer_architecture) (bn:00852566n) => In computing, a word is the natural unit of data used by a particular processor design.
    5. related: kilobit (bn:00048868n) => A unit of information equal to 1000 bits
    6. is-a: computer_memory_unit (bn:00021484n) => A unit for measuring computer memory

=end SYNOPSIS

use Cro::HTTP::Client;
use URI::Encode;

class BabelNet {
    has $.key;
    has $.language = 'EN';
    has $!client = Cro::HTTP::Client.new(
        :http('1.1'), # See https://github.com/croservices/cro-http/issues/74
        :Content-Type('application/json'),
        :base-uri('https://babelnet.io'),
    );

    # Returns the synset ids for the given word.
    method get-synset-ids( $word ) {
        return self!get-json( "/v5/getSynsetIds?lemma=$word&searchLang=$!language&key=$!key" );
    }

    # Returns the JSON of a Synset.
    method get-synset( $synset-id ) {
        return self!get-json( "/v5/getSynset?id=$synset-id&key=$!key" );
    }

    # Returns the JSON of all outgoing edges.
    method get-outgoing-edges( $synset-id ) {
        return self!get-json( "/v5/getOutgoingEdges?id=$synset-id&key=$!key" );
    }

    method !get-json( $uri ) {
        my $encoded = uri_encode($uri);
        my $response = await $!client.get( $encoded );
        return await $response.body;
    }
}


sub MAIN( :$key!, :$word!, :$depth = 6 ) {
    my $babel = BabelNet.new( :$key );
    my $synset-id = $babel.get-synset-ids( $word ).first.<id>;
    die "Could not find a synset-id for '$word'" if !$synset-id;

    for ( ^$depth ) -> $n {
        my $relationship = 'Initial';
        if ( $n > 0 ) {
            # Pick a random outgoing edge, limited by English.
            my $random-edge = $babel.get-outgoing-edges( $synset-id ).grep( { .<language> eq 'EN' } ).pick;
            die "No random edges for $synset-id" if !$random-edge;
            $relationship = $random-edge<pointer><shortName>;
            $synset-id = $random-edge<target>;
        }

        # Find the name and definition of the current synset-id.
        my $synset = $babel.get-synset( $synset-id );
        die "No senses/glosses for $synset-id" unless $synset<senses> && $synset<glosses>;

        my $name = $synset<senses>[0]<properties><fullLemma>;
        my $definition = $synset<glosses>[0]<gloss>;
        say ++$, ". $relationship: $name ($synset-id) => $definition";
        sleep 2; # Avoid flooding the server with our requests
    }
}


