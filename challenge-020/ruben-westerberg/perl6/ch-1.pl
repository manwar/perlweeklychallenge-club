#!/usr/bin/env perl6

my $input=@*ARGS[0]//"aabcDDefffgh";
my @a=$input.comb;
my @b;
for @a {
	state $prev=$_;
	state @stack;
	if $_ eq $prev {
		@stack.push: $_;
	}
	else {
		@b.push: @stack.join: "";
		@stack=();
		@stack.push: $_;

	}
	$prev=$_;
}
put @b.join: "|";
