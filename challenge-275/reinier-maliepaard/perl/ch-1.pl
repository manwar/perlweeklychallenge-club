#!/usr/bin/perl
use strict;
use warnings;

sub broken_keys {

    my ($regex) = "[@_[1 .. $#_]]";
    print( scalar( grep { ! /$regex/i } split(/ /, @_[0]) ), "\n" );
    @_[0] is aesthetically pleasing, scalar(@_[0]) is more precise, but normally
    you should use $_[0]

}

# Tests

my ($sentence, @keys);

# Example 1
$sentence = "Perl Weekly Challenge";
@keys = ('l', 'a');
broken_keys($sentence, @keys); # Output: 0

# Example 2
$sentence = "Perl and Raku";
@keys = ('a');
broken_keys($sentence, @keys); # Output: 1

# Example 3
$sentence = "Well done Team PWC";
@keys = ('l', 'o');
broken_keys($sentence, @keys); # Output: 2

# Example 4
$sentence = "The joys of polyglottism";
@keys = ('T');
broken_keys($sentence, @keys); # Output: 2
