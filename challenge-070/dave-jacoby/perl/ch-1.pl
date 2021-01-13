#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental::signatures };

use Carp;
use Getopt::Long;

# base case is the example;
my $string = 'perlandroku';
my $count  = 3;
my $offset = 4;

GetOptions(
    'string=s' => \$string,
    'count=i'  => \$count,
    'offset=i' => \$offset,
);

# constraints
my $n = length $string;
$n >= 0               || croak 'String too short';
$count >= 1           || croak 'Swap Count < 1';
$offset >= 1          || croak 'Offset < 1';
$count <= $offset     || croak 'Count > Offset';
$offset + $count < $n || croak 'Offset + Count < length of String';

char_swap( $string, $count, $offset );

sub char_swap ( $string, $count, $offset ) {
    my $n = length $string;
    print <<"END";
Input:
    S: $string
    C: $count
    O: $offset

Character Swapping:
END

    for my $c ( 1 .. $count ) {

        # the locations within the string
        my $p1 = ( $c % $n );
        my $p2 = ( $c + $offset ) % $n;

        # the characters in said positions
        my $c1 = substr $string, $p1, 1;
        my $c2 = substr $string, $p2, 1;

        # since we have the characters stored already
        # we don't need to store one and place the other
        substr( $string, $p1, 1 ) = $c2;
        substr( $string, $p2, 1 ) = $c1;

        say qq{    swap $c: $c1 <=> $c2 = $string};
    }
    print <<"END";

Output:
    $string
END
}
