#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Test::More;
use Unicode::Normalize;

sub makeover {
    my ( $str ) = @_;
    my $ascii = join "",      # Put it back together.
      map { /(.)/ }           # Get the first character fragment.
      map { /(\X)/g }         # Get each character.
      NFD $str;               # Incase the string is wierd.

    $ascii;
}

my @cases = (
    {
        name   => "Uppercase",
        input  => "ÃÊÍÒÙ",
        output => "AEIOU",
    },
    {
        name   => "Mixed case",
        input  => "âÊíÒÙ",
        output => "aEiOU",
    },
    {
        name   => "Really mixed case",
        input  => "âaÊíoÒÜuÙ",
        output => "aaEioOUuU",
    },
);

for ( @cases ) {
    is( makeover( $_->{input} ), $_->{output}, $_->{name} );
}

done_testing();
