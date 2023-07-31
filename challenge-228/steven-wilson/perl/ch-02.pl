#!/usr/bin/env perl

use 5.12.0;
use List::Util qw / min /;
use Test::More;

cmp_ok( empty_array( ( 3, 4, 2 ) ), '==', 5, "array out of order" );
cmp_ok( empty_array( ( 1, 2, 3 ) ), '==', 3, "array accending order" );
cmp_ok( empty_array( () ), '==', 0, "array empty" );
done_testing();

sub empty_array {
    my @elements = @_;
    my $ops      = 0;
    while (@elements) {
        if ( min(@elements) == $elements[0] ) {
            shift @elements;
        }
        else {
            my $element = shift @elements;
            push @elements, $element;
        }
        $ops++;
    }
    return $ops;
}
