#!/usr/bin/env perl6
use v6;

my @slices;
for 1..100 -> $i {
    @slices.push: @( $i, ( FatRat(1) - seconds(@slices).sum ) * $i / 100 );
}

print "Largest piece goes to guest # ";
my $max = seconds(@slices).max;
say firsts( @slices.grep( { $_[1] == $max } ) ).join(" ");

say "Slice size: { ($max * 100).fmt('%.2f') }% of the pie";

sub firsts(@array)  { return @array.map( { $_[0] } ) }
sub seconds(@array) { return @array.map( { $_[1] } ) }

