#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use List::Util qw/ first /;

sub find_greater_char {
    my ( $array, $target ) = @_;

    return ( first { $_ gt $target } sort { $a cmp $b } @$array ) // $target;
}

my $expected = [ qw/e c r c v/ ];
my @samples  = (
    [ [ qw/e m u g/ ], q/b/ ],
    [ [ qw/d c e f/ ], q/a/ ],
    [ [ qw/j a r/ ],   q/o/ ],
    [ [ qw/d c a f/ ], q/a/ ],
    [ [ qw/t g a l/ ], q/v/ ]
);

is_deeply( $expected, [ map { find_greater_char( @$_ ) } @samples ], 'found the correct chars?' );

done_testing( 1 );
