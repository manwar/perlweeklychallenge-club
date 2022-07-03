#!/usr/bin/perl
# 
# Task 2: First-class Function
# 
# Create sub compose($f, $g) which takes in two parameters $f and $g as
# subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x)
# = $f->($g->($x))
# 
# e.g.
# 
# $f = (one or more parameters function)
# $g = (one or more parameters function)
# 
# $h = compose($f, $g)
# $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...
# 
# MY NOTES: An interesting question at last.  Think it's quite easy..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;
use List::Util qw(sum0);

my $debug=0;
die "Usage: first-class-function [--debug] ARGS FOR FUNCS\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

#
# my $fg = compose( $f, $g );
#	Higher order function composer.  Return a newly minted
#	composed function (subroutine ref) that, when called, applies
#	$f first, then $g.
#
fun compose( $f, $g )
{
	return fun(@x) { return $f->($g->(@x)); }
}


my $sum       = fun( @x ) { return sum0(@x); };
my $double    = fun( @x ) { return map { 2 * $_ } @x };
my $sumdouble = compose( $sum, $double );
my $n = $sumdouble->( @ARGV );
say $n;
