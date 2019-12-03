#!/usr/bin/env perl6

my @dispatch= (1..10).map( { my $i=$_;sub { templateSub($i)}});

@dispatch[@dispatch.elems.rand.Int]() for @dispatch;

sub templateSub($i) {
	put "Hello from function $i";
}
