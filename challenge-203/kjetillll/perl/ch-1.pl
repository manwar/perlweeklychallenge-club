#!/usr/bin/perl
use strict; use warnings; #yes mom

=pod

Run with arguments to use those as the input list or
run without to run the included tests with this output:

ok     input: 1 2 3 6                expected: 1   got: 1
ok     input: 1 1 1 3 5              expected: 4   got: 4
ok     input: 3 3 6 4 5              expected: 0   got: 0
ok     input: 1 2 3 4 5 6 7 8 9 10   expected: 11   got: 11

For large input lists, use Algorithm::Combinatorics::combinations()
instead of sub comb. It's faster, otherwise they are compatible.
Install this with `sudo apt install libalgorithm-combinatorics-perl`
or `cpanm Algorithm::Combinatorics` or manually.

=cut

if( @ARGV ){ printf "Special quadruplets: %d\n", count_special_quad(@ARGV) }
else       { run_tests() }
exit;

sub comb { my($l,$k,$s)=(@_,0); $k ? map {my $i=$_; map[$$l[$i],@$_], comb($l,$k-1,$i+1) } $s..@$l-$k : [] }
sub is_special_quad { my( $a, $b, $c, $d ) = @_; $a + $b + $c == $d }
sub count_special_quad { 0 + grep is_special_quad(@$_), comb([ @_ ], 4) }

sub run_tests {
    for my $test (
	[1,2,3,6   => 1],
	[1,1,1,3,5 => 4],
	[3,3,6,4,5 => 0],
	[1..10     => 11],
    ){
	my $exp = pop @$test;
	my @input = @$test;
	my $got = count_special_quad(@input);
	printf "%-6s input: %-20s   expected: %d   got: %d\n",
	    $exp==$got ? 'ok': 'NOT OK',
	    "@input",
	    $exp,
	    $got
    }
}

