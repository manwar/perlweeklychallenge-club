#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $q = Complex->new(1);


foreach ( -10000 .. 10000 ) { #n16384 ) {
  my $t = Complex->new($_,0);
  my $q = $t->toQIB;
  my $c = $q->toComplex;
  say "$t         ->  $q  ->       $c    -> ",$c->toQIB if "$t" ne "$c";
}
exit;

package Complex;

sub new                  { bless [@_[1,2]], shift }
use overload '""' => sub { "$_[0][0] + $_[0][1] i" };
sub real                 { $_[0][0] }
sub imaginary            { $_[0][1] }
sub is_real              { !$_[0][1] }
sub toQIB                { QIB->new_from_Complex( $_[0] ); }

sub new_from_QIB {
  my($class,$r,$i,$f,@v) = ( $_[0], 0, 0, 1, split //, pop->[0] );
  $r += $f*pop @v, @v && ($i += $f*pop @v), $f*=-4 while @v;
  $class->new( $r, $i );
}


package QIB;

sub new                  { bless [pop], shift }
use overload '""' => sub { $_[0][0] };
sub value                { $_[0][0] }
sub toComplex            { Complex->new_from_QIB( $_[0] ) }

sub new_from_Real {
  my $class = shift;
  return $class->new(0) unless $_[0]; ## Null case!
  state @LOOK = qw(0000 0103 0102 0101 0100 0203 0202 0201 0200 0303 0302 0301 0300 0003 0002 0001);

  my ( $re, $n, @Q ) = ( $_[0]>0 ? '..$' : '$', $_[0]<0 ? -shift : 4*shift );

  (push @Q,$n%16), $n>>=4 while $n;                   ## Now we strip off the digit pairs

  for( my $j = my $l = 0; $l < @Q; $j = ++$l ) {      ## Now we sort out carries
    $Q[$j]-=16, $Q[++$j]++ while $Q[$j]>12;
  }
  ## And return the string...
  return $class->new( join( '', map {$LOOK[$_]} reverse @Q ) =~ s/^0+//r =~ s/$re//r );
}

sub new_from_Complex {
  my( $class, $c ) = @_;
  $class->new( $class->new_from_Real( $c->real      )->value
        + 10 * $class->new_from_Real( $c->imaginary )->value );
}

1;
