#!/usr/bin/perl

# Challenge 1: "Write a script that computes the equal point in the
# Fahrenheit and Celsius scales, knowing that the freezing point of water
# is 32 °F and 0 °C, and that the boiling point of water is 212 °F and
# 100."
#
# My notes: Isn't that just Maths?  solve F = 9/5C + 32 for F==C?
# 
# C = 9/5C + 32 => 4/5C = -32 => C = 5/4 x -32 = 5 x -8 = -40
# 
# But if I have to "compute" something that I should obviously "solve by
# algebra", could I do some sort of "where do two lines intersect" solver?
# Let's have a go.


use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

my $c = 0;
my $delta = 3.0;
my $epsilon = 0.000001;

#
# my $f = fahr($c);
#	Convert celsius $c to fahrenheit $f.
#
fun fahr( $c )
{
	return 9.0*$c/5.0 + 32;
}

#
# my $error = offby( $c );
#	Compute and return "how far is fahr(c) off by (different from c)"
#
fun offby( $c )
{
	return abs(fahr($c)-$c);
}


#die "c=0, f=", fahr(0), "\nc=100, f=", fahr(100), "\n";

# compute the intersection point of F = 9/5C + 32 and C = 5/9(F-32),
# ie. the value of c for which F(c)==c,
# using the fact that | F(c)-c | diminishes monotonically as we get
# closer to the solution value of c
# 
do {
	my $sd = ( offby($c-$delta) < offby($c) ) ?  -$delta : $delta;
	while( offby($c+$sd) < offby($c) )
	{
		$c += $sd;
	}
	print "c=$c, diff=", offby($c), ", delta=$delta\n";
	$delta /= 10.0;
} while( abs( fahr($c)-$c ) > $epsilon );

print "c=$c\n";
