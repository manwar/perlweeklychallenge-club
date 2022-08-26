[< Previous 177](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-177/james-smith) |
[Next 179 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-179/james-smith)

# The Weekly Challenge 178

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-178/james-smith

### Note

Have had a busy week (Coldplay concert and a few days away) - so have concentrated on task 1 this week.

# Task 1 - Damm Algorithm

***Write a script to convert a given number (base 10) to quater-imaginary base number and vice-versa.***

## Solution

Our first task is to write two packages one to represent both a complex number and one to create a QIB number.

### Complex numbers

This is fairly self-explanatory. We have standard methods, real, imaginary, is_real alons with new and
the overloaded "stringify" function.

A complex number is represented by a 2 element array.
```perl
package Complex;

sub new                  { bless [@_[1,2]], shift }
use overload '""' => sub { "$_[0][0] + $_[0][1] i" };
sub real                 { $_[0][0] }
sub imaginary            { $_[0][1] }
sub is_real              { !$_[0][1] }
sub toQIB                { QIB->new_from_Complex( $_[0] ); }

sub new_from_QIB {
  my( $class, $r, $i, $f, @v                 ) =
    ( $_[0],   0,  0,  1, split //, pop->[0] );

      ## Creates a new complex number from a QIB, computing
      ## the real and imaginary parts of the number, which are
      ## stored in alterating elements of the string.
  $r += $f*pop @v, @v && ($i += $f*pop @v), $f*=-4 while @v;

      ## Create the new object....
  $class->new( $r, $i );
}
````

```perl
use strict;
use warnings;
use feature qw(say state);

foreach ( -10000 .. 10000 ) { 
  my $t = Complex->new($_,0);
  my $q = $t->toQIB;
  my $c = $q->toComplex;
  say "$t         ->  $q  ->       $c    -> ",$c->toQIB if "$t" ne "$c";
}
````

```perl
package QIB;

sub new                  { bless [pop], shift }
use overload '""' => sub { $_[0][0] };
sub value                { $_[0][0] }
sub toComplex            { Complex->new_from_QIB( $_[0] ) }

sub new_from_Real {
  my $class = shift;
      ## Special case where r=0 - value is 0...
  return $class->new(0) unless $_[0]; ## Null case!

      ## Lookup (saves a bit of nasty mathes later
  state @LOOK = qw(0000 0103 0102 0101 0100 0203 0202 0201 0200 0303 0302 0301 0300 0003 0002 0001);

      ## If +ve we have to remove the last to digits (0) from the end of the string we generate
      ## Initial value is -v if v is less than 0 or 4v if v>0;
  my ( $re, $n, @Q ) = ( $_[0]>0 ? '..$' : '$', $_[0]<0 ? -shift : 4*shift );

      ## Strip off all the digit pairs {the reason for the *4 is that the last 2-digits in +ve values
      ##   become 4 digits...
  (push @Q,$n%16), $n>>=4 while $n;                   ## Now we strip off the digit pairs

      ## We have the values now apply some carries...
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
```
