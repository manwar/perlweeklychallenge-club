#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = @ARGV ? $ARGV[0] : 1;
$N<0?(method_one(-$N)):(method_two($N));

sub method_zero {
  my @e = map { my $a=$_; map {$a+$_}(0,2,4,6) }(0,30,40,50,60);
  shift @e;
  say join "\n",@e;
}

## works for $N up to 7 (numbers up to but not including 1 sextillion)
## There are no additional numbers for $N = 8 and 9.
## Then we have additional numbers for $N = 10 and 11.
## And then no eban numbers until we get to $N = 22
## So we need to some more complex code to work from $N=10 onwards
## as we have no solutions for numbers containing sextillion, septillion
## decillion to novemdecillion ..

## Units for which there are no "e" are used:
##   0 not-spelled at all except for Zero
##   2
##   4
##   6
## Tens for which there a no "e":
##   0 not-spelled at all (except when 0)
##  30
##  40
##  50
##  60
## We only need to find 2 digit eban numbers here as there are no 3
## digit eban numbers - hundred contains an "e"...


sub method_one {
  say for my@e=grep{$_}my@n=map{my$a=$_;map{$a+$_}(0,2,4,6)}(0,30,40,50,60);
  for(2..$_[0]) {
    say for @e=map{my$a=$_;map{sprintf'%s,%03d',$a,$_}@n}@e;
  }
}

## Slight optimization - we avoid sprintf which is sub-optimal
sub method_two {
  say for my@e=grep{$_}map{0+$_}(my@n=map{my$a=$_;map{'0'.$a.$_}(0,2,4,6)}(0,3..6));
  #say for my@e=map{0+$_}@n[1..@n-1];
  for(2..$_[0]) {
    say for @e=map{my$a=$_;map{$a.','.$_}@n}@e;
  }
}

########################################################################
## Now we extend these by adding more digits at the end so we get those
## less than 1 million, 1 billion etc.
## Note there would need to be a slight tweak when we get to sextillion,
## septillion to skip those numbers

########################################################################
## Just as an aside the number of eban numbers for $N is precisely
##    20^$N - 1 (up to including $N==7)
## The -1 is that the 20^$N includes the number 0 (which a isn't
## positive but contains a zero anyway if you call it "zero")
## There is an imprecise nature to this list as the definition does not
## specify where eban numbers can be negative - if this is the case any
## +ve eban number has an associated -ve eban number - and visa-versa.

# | Max   | (in words)  | Rate method 1 | Rate method 2 | %diff (2v1) |
# | ----: | :---------: | ------------: : ------------: : ----------: |
# |  10^3 | Thousand    |  200,481   /s |  104,559   /s |        -48% |
# |  10^6 | Million     |    6,996   /s |   10,311   /s |         47% |
# |  10^9 | Billion     |      343   /s |      500a  /s |         46% |
# | 10^12 | Trillion    |       15.4 /s |       26.2 /s |         70% |
# | ----: | :---------: | ------------: : ------------: : ----------: |
# | 10^15 | Quadrillion |        1.57 s |      0.811  s |         94% |
# | 10^18 | Quintillion |       29.5  s |     16.7    s |         77% |

