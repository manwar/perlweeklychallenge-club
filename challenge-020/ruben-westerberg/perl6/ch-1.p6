#!/usr/bin/env perl6

my $input=@*ARGS[0]//"aabcDDefffgh";
my @a=$input.comb;
my @b;
for @a {
	state $prev=$_;
	state @stack;
	when $prev {
		@stack.push: $_;
	}
	default {
		@b.push: @stack.join: "";
		@stack=();
		@stack.push: $_;
	}
	NEXT { $prev=$_;};
	LAST {@b.push: @stack.join: ""};
}
put @b.join: "|";
