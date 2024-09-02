use warnings;
use strict;

use v5.38;

use List::Util qw( max );

sub relative_sort( $list1, $list2 ) {
    my @list1 = @$list1;
    my @list2 = @$list2;

    my %ordering = map { ( $list2[ $_ ] => $_ ) } 0..$#list2;
    return (
	( sort { $ordering{ $a } <=> $ordering{ $b } } grep { exists $ordering{ $_ } } @list1 ),
	( sort grep { !exists $ordering{ $_ } } @list1 )
	);
}

my @inputs = (
    [
     [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
     [2, 1, 4, 3, 5, 6]
    ],
    [
     [3, 3, 4, 6, 2, 4, 2, 1, 3],
     [1, 3, 2]
    ],
    [
     [3, 0, 5, 0, 2, 1, 4, 1, 1],
     [1, 0, 3, 2]
    ]
    );
for (@inputs) {
    say join ( ', ', @{$_->[0]} ) . ' :: ' . join ( ', ', @{$_->[1]} ) . ' => ' . join ( ', ', relative_sort( $_->[0], $_->[1] ) );
    say '';
}
