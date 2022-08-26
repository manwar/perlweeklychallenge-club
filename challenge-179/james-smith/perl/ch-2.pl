#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Const::Fast qw(const);

binmode STDOUT, ':utf8';

const my $LINE  => "\x{2500}";
const my $START => "\x{2534}";
const my $FULL  => "\x{2577}";
const my $HALF  => "\x{2502}";

my @sets = (
  [200,199,198,3,4,4,10,8,7,199,10,24,10,7,10,11,20,25,3,3,3,3,3,3,3,3,3,3],
  [1,2,3,4,100,101,102],
);

say '';
for ( @sets ) {
  say for spark_line($_),'-'x 210,'';
  say for count_line($_),'='x 210,'';
}

sub spark_line {
  my($mx,$k,$l,%x)=0; $x{$_}++ for @{$_}; ($_>$mx) && ($mx=$_) for values %x;
  ## Top of lines if 2 or more matching values....
  map( {
    ($l,$k) = ($_<<1,-1); join '',
                          map { ' ' x ($_-$k-1).( $x{$_}<$l ? ' ' : $x{$_} == $l ? $FULL : $HALF ), ($k=$_)x 0 }
                          sort    { $a <=> $b }
                          keys    %x
  } reverse 1 .. $mx / 2 ),
  ## Base line ...
  ($k=-1)x 0,join( '', map { $LINE x ($_-$k-1) . $START,($k=$_)x 0 } sort {$a<=>$b} keys %x )
}

sub count_line {  ## Render the counts for the spark-line (for testing). if any value >= 10 we include a second
                  ## row for the tens...
  my($mx,$k,$l,%x)=0; $x{$_}++ for @{$_}; ($_>$mx) && ($mx=$_) for values %x;
  $mx>9 ? (($k=-1)x 0,(join '', map { " " x ($_-$k-1).(int($x{$k=$_}/10)||' ') } sort {$a<=>$b} keys %x )) : (),
  ($k=-1)x 0,(join '', map { " " x ($_-$k-1).$x{$k=$_}%10             } sort {$a<=>$b} keys %x )
}
