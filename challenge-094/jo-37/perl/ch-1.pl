#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'postderef';

our $examples;

run_examples() if $examples; # does not return

say(<<EOS), exit unless @ARGV;
Usage: $0 [-examples] [word ...]

-examples
    runs the given examples

word ... 
    use given words as input
EOS

# Apply "anagroup" to @ARGV and convert the result into the requested
# format.
say '[ ' .
    (join ', ', map {
        '(' . (join ', ', map {qq{"$_"}} @$_) . ')'
        } anagroup(@ARGV)) .
    ' ]';

# Group given strings by anagrams.
sub anagroup {
    # Hash to collect anagrams by a canonical key.
    my %anagroup;

    # Split strings into characters, sort and rejoin to gain a
    # "canonical anagram", decorate each string with its canonical
    # anagram and collect the strings within the prepared hash by
    # canonical key.
    push $anagroup{$_->[0]}->@*, $_->[1]
        foreach map {[join('', sort split //), $_]} @_;

    # Sort the canonical anagrams and retrieve the corresponding string
    # lists.  (The sort is required for a stable result only.)
    map {$anagroup{$_}} sort keys %anagroup;
}

sub run_examples {
    is [anagroup qw(opt bat saw tab pot top was)],
        [[qw(bat tab)], [qw(saw was)], [qw(opt pot top)]], 'Example 1';
    is [anagroup 'x'], [['x']], 'Example 2';

    done_testing;
    exit;
}
