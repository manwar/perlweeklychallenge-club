#!/usr/bin/perl
use Math::Prime::Util 'divisor_sum';
my $want = shift // 20;
my($have,$n)=(0,1);
Math::Prime::Util::divisor_sum($n)-$n > $n
    and print "$n\n"
    and $have++
    while $have < $want
      and $n+=2;

#945 1575 2205 2835 3465 4095 4725 5355 5775 5985 6435 6615 6825 7245 7425 7875 8085 8415 8505 8925
