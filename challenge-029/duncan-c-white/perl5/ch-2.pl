#!/usr/bin/perl
#
# Challenge 2: "Write a script to demonstrate calling a C function. It
# could be any user defined or standard C function."
# 
# My notes: Hmm, either XS or Inline::C.  I've never used either:-)
# Wrote simple sqrt routine (algorithm: squaring the rectangle) in C,
# wrote the same in Perl, then used Benchmark to benchmark both versions.
#

use v5.10;	# for "say"
use strict;
use warnings;
#use Data::Dumper;
use Function::Parameters;
use Benchmark qw(:all);

use Inline 'C';


fun perl_sqrt( $x )
{
  my $EPSILON = 0.00001;
  my $w=1.0;
  for(;;)
  {
  	my $h=$x/$w;
  last if abs($h-$w)<$EPSILON;
	$w = ($w+$h)/2;
  }
  return $w;
}


#greet('thingy');
#greet(42);
#greet(4.6);
my $sc = c_sqrt( 145 );
my $sp = perl_sqrt( 145 );
print "sqrt(145)=$sc by C, =$sp by perl\n";

timethese( 10000000,
	{
	"C"    => sub { c_sqrt(145); },
	"perl" => sub { perl_sqrt(145); }
	} );
__END__
__C__
void greet(SV* sv_name) {
  printf("Hello %s!\n", SvPV(sv_name, PL_na));
}
double c_sqrt( double x ) {
  #define EPSILON 0.00001
  double w=1.0;
  for(;;)
  {
  	double h=x/w;
  if( fabs(h-w)<EPSILON ) break;
	w = (w+h)/2;
  }
  return w;
}
