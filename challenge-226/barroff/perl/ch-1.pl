#!/usr/bin/env perl

use v5.38;
use List::Util qw( zip );

sub shuffle_string ( $string, @ints ) {
    my %string_dict;
    my @split_string = split( //, $string );
    map( $string_dict{ @$_[0] } = @$_[1], zip( \@ints, \@split_string ) );
    join '', @string_dict{ 0 .. length($string) - 1 };
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 2;

    is shuffle_string( 'lacelengh', ( 3, 2, 0, 5, 4, 8, 6, 7, 1 ) ),
      'challenge', 'works for lacelengh';
    is shuffle_string( 'rulepark', ( 4, 7, 3, 1, 0, 5, 2, 6 ) ),
      'perlraku', 'works for rulepark';
}

MAIN();
