#!/usr/bin/env perl6
center(lines())>>.say;
sub center(*@lines) {
	my $max= max @lines>>.chars;
	map {' ' x ($max - .chars)/2 ~$_}, @lines;
}


