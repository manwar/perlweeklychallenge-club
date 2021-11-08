#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

ok( is_binary_palindrome(5) == 1,
    "Output: 1 as binary representation of 5 is 101 which is Palindrome." );
ok( is_binary_palindrome(4) == 0,
    "Output: 0 as binary representation of 4 is 100 which is NOT Palindrome."
);
done_testing();

sub is_binary_palindrome {
    my $integer = shift;
    my $binary  = sprintf( "%b", $integer );
    if ( $binary eq reverse $binary ) {
        return 1;
    }
    else {
        return 0;
    }
}
