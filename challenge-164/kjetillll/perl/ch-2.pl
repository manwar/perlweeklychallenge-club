#!/usr/bin/perl
use List::Util 'sum'; use strict; use warnings;

sub is_happy {
    my $n = shift;
    my(%seen,$happy);
    $happy = sub {
	my $n = shift;
	$n==1 ? 1 : $seen{$n}++ ? 0 : &$happy(sum( map $_**2, $n=~/\d/g ));
    };
    &$happy( $n );
}

my($want, $count, $n) = (8, 0, 0);

is_happy(++$n)
  and print "Found happy number ".++$count.": $n\n"
    while $count < $want;
