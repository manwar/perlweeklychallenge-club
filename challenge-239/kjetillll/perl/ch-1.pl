#!/usr/bin/perl
#command line example: perl ch-1.pl "a bc d efg" "ab cde f g"

use strict; use warnings; use v5.10;

sub same_string {
    my($array1, $array2) = @_;
    "@$array1" =~ s/\s//gr eq
    "@$array2" =~ s/\s//gr
}

@ARGV ? run_args(@ARGV)
      : run_tests();

sub run_args {
    say same_string( map [split/\s+/], @_[0,1] );
}

sub run_tests {
    for my $test (
	{   arr1 => ["ab", "c"],
	    arr2 => ["a", "bc"],
	    output => 1
	},
	{   arr1 => ["ab", "c"],
	    arr2 => ["ac", "b"],
	    output => 0
	},
	{   arr1 => ["ab", "cd", "e"],
	    arr2 => ["abcde"],
	    output => 1
	}
    ){
	my $got = same_string( $$test{arr1}, $$test{arr2} );
	say $$test{output} == $got ? 'ok' : '***NOT OK',
	    "   arr1: @{$$test{arr1}}",
	    "   arr2: @{$$test{arr2}}",
	    "   output: $$test{output}",
	    "   got: $got";
    }
}

