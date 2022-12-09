#!/usr/bin/env raku

=begin comment

AUTHOR: Robert DiCicco

DATE: 2022-12-05

Challenge 194 Digital Clock ( Raku )

-------------------------------------------

SAMPLE OUTPUT

raku .\DigitalClock.rk

Input: $time = '?5:00'

Output: 1

 

Input: $time = '?3:00'

Output: 2

 

Input: $time = '1?:00'

Output: 9

 

Input: $time = '2?:00'

Output: 3

 

Input: $time = '12:?5'

Output: 5

 

Input: $time = '12:5?'

Output: 9

=end comment

 

use v6;

 

my @templates = ('?5:00', '?3:00', '1?:00', '2?:00', '12:?5','12:5?');

 

sub GetDigit($tp, $n) {

  print "Input: \$time = \'$tp\'\n";

  print "Output: ";

  if (( $n == 0 ) && (substr($tp,1,1) < '4')) {

    say "2";

  }

  elsif (( $n == 0 ) && (substr($tp,1,1) >= '4' )) {

    say "1";

  }

  elsif (($n == 1) && (substr($tp,0,1) <= '1')) {

   say "9";

  }

  elsif (($n == 1) && (substr($tp,0,1) == '2')) {

   say "3";

  }

  elsif ($n == 3)  {

   say "5";

  }

  elsif ($n == 4)  {

   say "9";

  }

  else {die "Error!"};

  say " ";

}

 

for @templates -> $tp {

  #say $tp;

  GetDigit($tp,$tp.index('?'));

}
