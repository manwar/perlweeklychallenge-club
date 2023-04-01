#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 209 Task 1: Special Bit Characters
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

sub special_bit_characters {
    return join( "", @_ ) =~ /^ ( 10 | 01 )* 0 $/x || 0;
}


use Test::More;

my @tests = (
    [ special_bit_characters => [
        { INPUT => [ 1, 0, 0 ],    EXPECTED => [ 1 ] },
        { INPUT => [ 1, 1, 1, 0 ], EXPECTED => [ 0 ] },
    ] ],
);

for ( @tests ) {
    my $sub_name = $_->[0];
    my $sub = \&$sub_name;
    for ( @{$_->[1]} ) {
        my $test_name = $_->{TEST_NAME}
            // ( "$sub_name( "
                . join( " ", @{$_->{INPUT}} )
                . " ) -> "
                . join( " ", @{$_->{EXPECTED}} ) );
        is_deeply [ special_bit_characters( @{$_->{INPUT}} ) ],
            $_->{EXPECTED},
            $test_name;
    }
}

done_testing;

1;