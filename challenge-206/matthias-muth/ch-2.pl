#!/usr/bin/env perl

use strict;
use warnings;

use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw( min max sum );

sub permute( $a_ref ) {
    return undef  unless defined $a_ref && ref $a_ref eq 'ARRAY';
    return ()     if @$a_ref == 0;
    return $a_ref if @$a_ref == 1;

    my @permutations;
    for my $i ( 0..$#$a_ref ) {
	my @others = @$a_ref;
	my $extracted = splice( @others, $i, 1, () );
	push @permutations, [ $extracted, @$_ ]
	    for permute( [ @others ] );
    }
    return @permutations;
}

sub sum_of_min_of_pairs( @a ) {
    return undef
	unless @a % 2 == 0;
    return
	sum( map $_ % 2 == 0 ? min( $a[$_], $a[ $_ + 1 ] ) : 0, 0 .. $#a - 1 );
}

sub max_of_sums( @a ) {
    return undef
	unless @a % 2 == 0;
    return 
	max( map sum_of_min_of_pairs( @$_ ), permute( [ @a ] ) );
}


use Test::More;

my @tests = (
    [ [],              undef ],
    [ [ 11 ],          undef ],
    [ [ 11,12 ],       11    ],
    [ [ 1,2,3,4,5,6 ], 9     ],
    [ [ 1,2,3,4 ],     4     ],
    [ [ 0,2,1,3 ],     2     ],
);

is max_of_sums( @{$_->[0]} ), $_->[1],
    "max_of_sums( @{$_->[0]} ) == " . ( $_->[1] // "undef" )
    for @tests;

done_testing;

__END__

use v5.10;

# For testing:
for ( @tests ) {
    say "Permutations of @{$_->[0]}:";
    my @permutations = permute( [ @{$_->[0]} ] );
    say "    @{$_}"
	for @permutations;
}
