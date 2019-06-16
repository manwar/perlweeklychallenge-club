#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

use Mojolicious::Lite;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

get '/services/v2/syno.php' => sub ($c) {
    if ( ( $c->param('uid') // '' ) ne '1001' ) {
        say $c->param('uid');
        $c->render( status => 500, json => { error => 'Invalid User ID' } );
    } elsif ( ( $c->param('tokenid') // '' ) ne 'tk324324' ) {
        $c->render( status => 500, json => { error => 'Invalid Token' } );
    } elsif ( ( $c->param('format') // '' ) ne 'json' ) {
        $c->render( status => 500, json => { error => 'Invalid Format' } );
    } elsif ( ( $c->param('word') // '' ) eq '' ) {
        $c->render( status => 500, json => { error => 'Must provide word' } );
    } elsif ( $c->param('word') eq 'bogus word' ) {
        say "WORD: " . $c->param('word');
        $c->render( json => {} );
    } else {
        say "WORD: " . $c->param('word');
        $c->render(
            json => {
                result => [
                    {
                        term => "consistent",
                        definition =>
                          "(sometimes followed by 'with') in agreement or consistent or reliable",
                        partofspeech => "adj",
                        synonyms     => "ordered, coherent, logical, reproducible, uniform",
                        antonyms =>
"scratchy, unreconciled, uneven, contradictory, inconsistent, conflicting, incompatible, spotty, heterogeneous, discrepant, heterogenous, self-contradictory, unconformable",
                    },
                ],
            }
        );
    }
};

app->start;
