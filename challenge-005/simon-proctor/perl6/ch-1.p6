#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Anagrams;

my %*SUB-MAIN-OPTS = :named-anywhere;

sub USAGE { say $*USAGE }

subset FilePath of Str where *.IO.f;

#| Display Help file
multi sub MAIN ( Bool :h($help) where *.so ) { USAGE(); }

#| Find the anagrams for a given word
multi sub MAIN (
    Str $word, #= Word to check for. Case insensitive
    FilePath :$dict = "/etc/dictionaries-common/words" #= Dictionary file to use. Defaults to "/etc/dictionaries-common/words"
) {
    $dict.IO.words.grep( { is-anagram-of( $word, $_ ) } )>>.say;
}
