#!/usr/bin/env raku

use Trie;

my $trie = Trie.new;

$trie.insert: $_ for <alphabet book carpet cadmium cadeau alpine>;

my @prefixes = gather {
    for ^$trie.elems -> $i {
        my $length;
        my $prefix;

        repeat {
            $length++;
            $prefix = $trie[$i].substr(0, $length);
        } while ($trie.get-all: $prefix).elems > 1;

        take $prefix; 
    }
}

say @prefixes;
