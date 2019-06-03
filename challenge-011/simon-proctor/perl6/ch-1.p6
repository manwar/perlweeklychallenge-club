#!/usr/bin/env perl6
use v6;

my %lower = :0C, :32F;

my %upper = :100C, :212F;

my $delta = (%upper<C> - %lower<C>) / (%upper<F> - %lower<F>);

my %temps = ( C => %lower<C>, F => %lower<F> );

while %temps<C> != %temps<F> {
    %temps<F> -= 1;
    %temps<C> -= ( 1 * $delta );
} 

say %temps<C>;
