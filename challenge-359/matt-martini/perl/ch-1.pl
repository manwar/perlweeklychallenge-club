#!/usr/bin/env perl

# You are given a positive integer, $int.

# Write a function that calculates the additive persistence
# of a positive integer and also return the digital root.

#     Digital root is the recursive sum of all digits in a
#     number until a single digit is obtained.

#     Additive persistence is the number of times you need
#     to sum the digits to reach a single digit.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub digital_root {
    my $int = shift;

    print 'Input: $int = ' . $int . "\n";

    my $persistence  = 0;
    my $digital_root = 0;

    while ( ( length "$int" ) > 1 ) {
        my $sum = 0;
        $sum += $_ for split( '', "$int" );
        $persistence++;
        $int = $sum;
    }
    $digital_root = $int;

    say 'Output: Persistence  = ' . $persistence;
    say '        Digital Root = ' . $digital_root;
    return [ $persistence, $digital_root ];
}

my @examples = (
                 { in => 38,         out => [ 2, 2 ], name => 'example 1' },
                 { in => 7,          out => [ 0, 7 ], name => 'example 2' },
                 { in => 999,        out => [ 2, 9 ], name => 'example 3' },
                 { in => 1999999999, out => [ 3, 1 ], name => 'example 4' },
                 { in => 101010,     out => [ 1, 3 ], name => 'example 5' },
               );

is( digital_root( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

