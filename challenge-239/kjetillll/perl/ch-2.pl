#!/usr/bin/perl
#command line example:  perl ch-2.pl cc acd b ba bac bad ac d   cad

use strict; use warnings; use v5.10;

sub count_consistent {
    -1 + grep /^[$_[-1]]+$/, @_
}

@ARGV ? run_args(@ARGV)
      : run_tests();

sub run_args {
    say count_consistent(@_);
}

sub run_tests {
    for my $test (
	{ str     => ["ad", "bd", "aaab", "baa", "badab"],
	  allowed => "ab",
	  output  => 2
	},
	{ str     => ["a", "b", "c", "ab", "ac", "bc", "abc"],
	  allowed => "abc",
	  output  => 7
	},
	{ str     => ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"],
	  allowed => "cad",
	  output  => 4
	}
    ){
	my $got = count_consistent( @{$$test{str}}, $$test{allowed} );
	say $$test{output} == $got ? 'ok' : '***NOT OK',
	    "   str: @{$$test{str}}",
	    "   allowed: $$test{allowed}",
	    "   output: $$test{output}",
	    "   got: $got";
    }
}

