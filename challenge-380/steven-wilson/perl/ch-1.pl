#!/usr/bin/env perl

use v5.42;
use Test2::Bundle::More;
use List::Util qw(max);

my @VOWELS = ('a', 'e', 'i', 'o', 'u');

sub sof{
	my $input = shift;
	my @letters = split(//, $input);
	my %vowels = ();
	my %consonants = ();
	foreach my $l (@letters){
		if (grep { $_ eq $l } @VOWELS){
			$vowels{$l}++;
		} else {
			$consonants{$l}++;
		}
	} 
	my $max_v = max(values %vowels) // 0;
	my $max_c = max(values %consonants) // 0;
	return $max_v + $max_c;
}

is(sof('banana'), 5);
is(sof('teestett'), 7);
is(sof('aeiouuaa'), 3);
is(sof('rhythm'), 2);
is(sof('x'), 1);
is(sof(''), 0);

done_testing();
