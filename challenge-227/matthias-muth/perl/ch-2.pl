#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 227 Task 2: Roman Maths
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

use Roman;

my %ops = (
    '+'  => sub { $_[0] + $_[1] },
    '-'  => sub { $_[0] - $_[1] },
    '*'  => sub { $_[0] * $_[1] },
    '/'  => sub { $_[0] / $_[1] },
    '**' => sub { $_[0] ** $_[1] },
);

sub roman_maths( @input ) {
    my $result = $ops{$input[1]}->( arabic( $input[0] ), arabic( $input[2] ) );
    return 
        $result == 0
	    ? "nulla (they knew about zero but didn't have a symbol)" :
	$result != int( $result )
	    ? "non potest (they didn't do fractions)" :
	$result > 3999
	    ? "non potest (they only went up to 3999)" :
	$result < 0
	    ? "non potest (they didn't do negative numbers)" :
	Roman( $result );
}

run_tests;
