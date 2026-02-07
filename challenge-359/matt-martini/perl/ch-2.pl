#!/usr/bin/env perl

# You are given a word containing only alphabets,

# Write a function that repeatedly removes adjacent duplicate
# characters from a string until no adjacent duplicates remain
# and return the final word.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub encrypted_string {
    my $str    = shift;
    my $result = q{};

    print 'Input: $word = "' . $str . '"' . "\n";

    while ( $str =~ s{(.)\1}{}g ) {
        1;
    }
    $result = $str;
    say 'Output: "' . $result . q{"};
    return $result;
}

my @examples = (
                 { in => "aabbccdd",    out => "",       name => 'example 1' },
                 { in => "abccba",      out => "",       name => 'example 2' },
                 { in => "abcdef",      out => "abcdef", name => 'example 3' },
                 { in => "aabbaeaccdd", out => "aea",    name => 'example 4' },
                 { in => "mississippi", out => "m",      name => 'example 5' },
               );

is( encrypted_string( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

