#!/usr/bin/perl6
use v6;

use Test;

=begin pod
Task 33.1
Count Letters (A..Z)
Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.
So with the following input file sample.txt
The quick brown fox jumps over the lazy dog.
the script would display something like:
a: 1
b: 1
c: 1
d: 1
e: 3 etc.
=end pod


sub count($text) {
    return BagHash.new( $text.lc.comb.grep: * ~~ / <alpha> / );
}

multi MAIN(*@files) {
    my BagHash $bag;
    for @files -> $f {
        next unless $f.IO:f;
        $bag{.key}+=.value for count($f.IO.slurp); # Add returned bag to bag hash
    }
    $bag{"_"}:delete;
    say "$_: {$bag{$_}}" for $bag.keys.collate;
}


multi MAIN("test") {
    my $i=BagHash.new(<a b b>);
    my $j=BagHash.new(<á b b>);
    is-deeply count("abb"),$i,"test counts";
    is-deeply count("Abb"),$i,"test lowercase";
    is-deeply count("Ább"),$j,"test lowercase2";
    is-deeply count("a 1 b\n.b!"),$i,"test not counting non-words";
}
