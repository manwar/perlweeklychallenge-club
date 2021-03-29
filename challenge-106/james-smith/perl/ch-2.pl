#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( decimal_string(1,97), '0.(010309278350515463917525773195876288659793814432989690721649484536082474226804123711340206185567)' );
is( decimal_string(620,119), '5.(210084033613445378151260504201680672268907563025)');
is( decimal_string(1,6000), '0.0001(6)' );
is( decimal_string(1,51), '0.(0196078431372549)' );
is( decimal_string(1,7),  '0.(142857)' );
is( decimal_string(1,3),  '0.(3)' );
is( decimal_string(1,12), '0.08(3)' );
is( decimal_string(5,3),  '1.(6)' );
is( decimal_string(6,3),  '2' );
is( decimal_string(1,2),  '0.5' );
is( decimal_string(5,66), '0.0(75)' );

done_testing();

sub decimal_string {
  my( $D,    $whole_part,      $N,            $res ) =
    ( $_[1], int($_[0]/$_[1]), $_[0] % $_[1], ''   );

  ## "Long division" to arbitrary precision...
  return $whole_part if $N == 0;

  ($res,$N) = $D>$N ? ($res.'0',$N.'0')
                    : ($res.int($N/$D),($N%$D).'0')
      foreach 0 .. 2*$D;

  ## Find a recurring sequence... and remove it!
  ## We look for the "shortest" sequence - but it must be tied to the
  ## RHS of our result string....

  $res =~ s{(\d+?)\1+$}{}g;

  my $recurring = $1;

  ## $recurring is the recurring digits - it may be "0"s in which case
  ## the number is represented by a finite (non recurring decimal)
  ##
  ## As this is a recurring sequence tied to the end of the string, we
  ## need to look to see if we rotate it to see if it started earlier..
  ##
  ## So we compare the last letter of the string & the recurring
  ## string and if it matches we move it to the start of the recurring
  ## sequence and strip the last letter of both strings....
  ##
  ## (chomp $str).$str <- achieves this rotation....
  ##
  ## Note the little nastiness here - to make the while loop a
  ## one-liner we allocate $recurring to the first of the list of
  ## "list" on the RHS of the = sign and drop the other (chop $res)

  ($recurring) = (chop $recurring).$recurring, chop $res
    while (substr $res,-1) eq substr $recurring, -1;

  substr $res, 0, 1, "$whole_part."; ## Replace leading 0 with
                                     ## The whole part we removed
                                     ## above for dealing with N>D

  $res .= "($recurring)" unless $recurring eq '0';

  return $res;
}

