#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub capital_detection {
    my ($s) = @_;
    return 1 if $s =~ /^[A-Z][a-z]*$/;    # Rule 1
    return 1 if $s =~ /^[a-z]+$/;         # Rule 2
    return 1 if $s =~ /^[A-Z]+$/;         # Rule 3
    return 0;
}

is( capital_detection('Perl'),   1, 'Example 1' );
is( capital_detection('TPF'),    1, 'Example 2' );
is( capital_detection('PyThon'), 0, 'Example 3' );
is( capital_detection('raku'),   1, 'Example 4' );

done_testing();
