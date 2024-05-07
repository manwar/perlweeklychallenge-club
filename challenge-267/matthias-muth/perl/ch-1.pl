#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 267 Task 1: Product Sign
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( product );

sub product_sign( @ints ) {
    return product map $_ <=> 0, @ints;
}

sub product_sign_shortcut( @ints ) {
    return product map { $_ <=> 0 or return 0 } @ints;
}

sub benchmark() {
    use Benchmark qw( :all );
    my @ints = ( -500 .. -1, +1 .. 500 );
    my @ints_0 = ( -500      ..      499 );
    cmpthese( -2 => {
	"product_sign"            => sub() { product_sign( @ints ) }, 
	"product_sign_shortcut"   => sub() { product_sign_shortcut( @ints ) }, 
	"product_sign_0"          => sub() { product_sign( @ints_0 ) }, 
	"product_sign_shortcut_0" => sub() { product_sign_shortcut( @ints_0 ) }, 
    } );
}
# benchmark();
# exit 0;

use Test2::V0 qw( -no_srand );
is product_sign( -1, -2, -3, -4, 3, 2, 1 ), 1,
    'Example 1: product_sign( -1, -2, -3, -4, 3, 2, 1 ) == 1';
is product_sign( 1, 2, 0, -2, -1 ), 0,
    'Example 2: product_sign( 1, 2, 0, -2, -1 ) == 0';
is product_sign( -1, -1, 1, -1, 2 ), -1,
    'Example 3: product_sign( -1, -1, 1, -1, 2 ) == -1';
done_testing;

