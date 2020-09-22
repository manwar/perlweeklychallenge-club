#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes qw(time);

foreach (@ARGV) {
  my $t = time;
  my $q = count_set_bits($_);
  my $d = time-$t;
     $t = time;
  my $q2 = naive_count_set_bits($_);
  my $d2 = time-$t;
  printf "%15d\t%15d\t%15d\t%12.6f\t%12.6f\t%12.3f\n", $_, $q, $q2, $d, $d2, $d2/$d;
}

## Counting isn't the best way - we can work this out only looking at the current
## number.
##
## The count for the integers 1 .. (2^n-1) is n(2^n)/2
##
## We can use this information to get the total...
## Get array of bits for "i+1"
## Foreach bit in this representation which is 1 - we count the number of bits
## in that chunk of the number so e.g.
##  i = 22
##  Then the bit array is 1,0,1,1,1
##
## Loop through the bits and use the count method above to count the lower bits
## of each group (ignore any where the value in the bit array is 0)
## The higher bits are counted by multiplying the size of the group by the bits
## in the "higher bit" e.g. 16, 20, 22 below... What we note though is that this
## number increases by 1 each time that we loop through the array
##
## So in the example above the chunks become:
##  1..15 - split this into 16 x "0"  & 0..15  - total is 2^4 * 0 + 4(2^4)/2 = 32
## 16..19 - split this into  4 x "16" & 0..3   - total is 2^2 * 1 + 2(2^2)/2 =  8
## 20..21 - split this into  2 x "20" & 0..1   - total is 2^1 * 2 + 1(2^1)/2 =  5
## 22     - split this into  1 x "22" & 0      - total is 2^0 * 3 + 0(2^0)/2 =  3
##                                                                             48
## I have included the naive method for comparison....
## the naive method is O(n ln(n)) and the optimal method is O(ln(n))
## Numbers below to show this...

## we see the following performance
##  "i"           "count"       "fast"     "naive"       "speed up"
##            1             1   0.000017    0.000008             0.458
##           10            17   0.000014    0.000007             0.492
##          100           319   0.000012    0.000022             1.840
##        1,000         4,938   0.000010    0.000187            18.690
##       10,000        64,613   0.000019    0.001943           101.875
##      100,000       815,030   0.000035    0.076236         2,175.218
##    1,000,000     9,884,999   0.000034    0.835451        24,677.007
##   10,000,000   114,434,632   0.000034    8.543442       250,585.965
##  100,000,000   314,447,109   0.000041   95.227608     2,322,171.727


sub count_set_bits {
  my $i = shift;
  my @q = split m{}, sprintf '%b', $i+1;
  my $t = my $s = 0;
  while (@q) {
    next unless shift @q;
    $t += ($s + @q/2)*(1<<@q);
    $t %= 1000000007;
    $s++;
  }
  return $t;
}

sub naive_count_set_bits {
  my $c = 0;
  $c   += (sprintf "%b", $_) =~ tr/1/1/ for 1..shift;
  return $c % 1000000007;
}

#  "i"           "count"       "fast"     "naive"       "speed up"
#            1             1   0.000017    0.000008             0.458
#           10            17   0.000014    0.000007             0.492
#          100           319   0.000012    0.000022             1.840
#        1,000         4,938   0.000010    0.000187            18.690
#       10,000        64,613   0.000019    0.001943           101.875
#      100,000       815,030   0.000035    0.076236         2,175.218
#    1,000,000     9,884,999   0.000034    0.835451        24,677.007
#   10,000,000   114,434,632   0.000034    8.543442       250,585.965
#  100,000,000   314,447,109   0.000041   95.227608     2,322,171.727

#
