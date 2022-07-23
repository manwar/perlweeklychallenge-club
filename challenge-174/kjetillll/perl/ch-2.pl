#!/usr/bin/perl
use List::MoreUtils 'indexes'; use v5.10; use strict; use warnings;

say permutation2rank( [1,0,2] );

say "[@{[@{rank2permutation( [0,1,2], 1 )}]}]" if $"=',';

sub permutation2rank {
    indexes {"@$_" eq "@{ $_[0] }"} perms( sort {$a<=>$b} @{ $_[0] } )
}

sub rank2permutation {
    ( perms( @{ $_[0] } ) )[pop]
}

sub perms {
    my(@i,@r) = 0..$#_;
    @_ || return;
    while ( push @r, [@_[@i]] ) {
	my $p = $#i || last;
	--$p || last while $i[$p-1] > $i[$p];
	push @i, reverse splice @i, my$q=$p;
	++$q while $i[$p-1] > $i[$q];
	@i[$p-1,$q] = @i[$q,$p-1];
    }
    @r
}
