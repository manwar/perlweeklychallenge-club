#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use List::Util qw(sum0);
use Time::HiRes qw(time);

my %cache;
my @RES = (0,
                  1,                 2,                 3,                 8,              10, # 1- 5
                 36,                41,               132,               250,             700, # 6-10
                750,             4_010,             4_237,            10_680,          24_679, #11-15
             87_328,            90_478,           435_812,           449_586,       1_939_684, #16-20
          3_853_278,         8_650_900,         8_840_110,        60_035_322,      80_605_209, #21-25
        177_211_024,       368_759_752,     1_380_348_224,     1_401_414_640,   8_892_787_136, #26-30
      9_014_369_784,    33_923_638_848,    59_455_553_072,   126_536_289_568, 207_587_882_368, #31-35
  1_495_526_775_088, 1_510_769_105_288, 3_187_980_614_208, 5_415_462_995_568,                  #36-39
);
my $N   = 25; # N up to 20 works with all methods...
## We will use memoization to improve performance!!

is( cute(                    $_ ), $RES[$_] ) for 1..$N;
is( cute_no_order(          $_ ), $RES[$_] ) for 1..$N;
is( cute_no_cache(          $_ ), $RES[$_] ) for 1..$N;
is( cute_no_order_no_cache( $_ ), $RES[$_] ) for 1..$N;

done_testing();

#my $t1 = my $t0 = time; (printf "%3d\t%15d\t%10.6f\t%10.6f\n", $_, cute($_), time-$t0, time-$t1),$t0=time for 1..50;

## A quick bit of prep - for each position we want to keep a list
## of possible digits.
## Then for ultimate perforance we sort them into a list in
## size order - so start with the position with least possible numbers
## and work up!!

cmpthese( -5 , {
  'cache-order'        => sub { cute($_) for 1..$N },
  'cache-no-order'     => sub { cute_no_order($_) for 1..$N },
  'no-cache-order'     => sub { cute_no_cache($_) for 1..$N },
  'no-order-no-cache'  => sub { cute_no_order_no_cache($_) for 1..$N },
});

sub cute {
    ## Clear cache...
  %cache=();
    ## If n is 1 short cut and return 1
  $_[0]==1 ? 1 : _cute_count( 0,
      ## Just keep the lists
    map  { $_->[1] }
      ## Sort so the shortest lists are first - then sort by integer
    sort { @{$a->[1]} <=> @{$b->[1]} || $a->[0]  <=>   $b->[0] }
      ## Find all values between 1 & n which are either a factor or
      ## multiple. Store each as pair, of the number + all values.
    map  {[ ($a=$_) => [ grep { !( $_%$a && $a%$_ ) } 1 .. $_[0] ] ] }
      ## Looping over 1 to n
    1 .. $_[0]
  )
}

sub _cute_count {
  my( $seen, $next ) = ( shift, shift );
    ## If we have already computed the value return...
    ## otherwise we loop over the values possible in the
    ## "nth" position (this is loose as they aren't ordered directly)
    ## by " but by the count {we are only counting so don't need to
    ## produce numbers}
    ## We sum up the value for each value in this list which hasn't
    ## been seen we return.
    ## If there is only 1 number left in the list we count 1
    ##   (as all numbers can be in the last position)
    ## o/w we call this method again after knocking out the number
  $cache{$seen} //= sum0 map { ($seen & 1<<$_) ? 0 : @_ < 2 ? 1 :
                      _cute_count( $seen | 1<<$_ , @_ ) } @{$next}
    ## Note we don't use a string as a key - but use a bit mast -
    ## using "|" to set a bit & "&" to check it has been set.
}

sub cute_no_cache {
  my $N = shift;
  my @map = ( 0, map  { $a=$_; [ grep { ! ( $_%$a && $a%$_ ) } 1..$N ] } 1..$N );
  _cute_count_no_cache( 0,
    map { $map[$_] }
    sort { @{$map[$a]} <=> @{$map[$b]} || $a <=> $b }
    1..$N
  );
}


sub cute_no_order_no_cache {
  my $N = shift;
  my @map = ( 0, map  { $a=$_; [ grep { ! ( $_%$a && $a%$_ ) } 1..$N ] } 1..$N );
  return _cute_count_no_cache( 0,
    map { $map[$_] }
    1..$N
  );
}


sub cute_no_order {
  my $N = shift;
  my @map = ( 0, map  { $a=$_; [ grep { ! ( $_%$a && $a%$_ ) } 1..$N ] } 1..$N );
  %cache=();
  return _cute_count_no_order( 0, map { $map[$_] } 1..$N);
}

## $seen is bit flag of seen numbers  { as we know that $n is low < 63 we can use this trick! }
## $next is the next list of numbers to try
## @_    the remaining lists of numbers to try
sub _cute_count_no_cache {
  my( $seen, $next ) = ( shift, shift );
  my @nos = grep { !( $seen & 1<<$_ ) } @{$next};
  @_ ? sum0 map { _cute_count_no_cache( $seen | 1<<$_ , @_ ) } @nos
     : scalar @nos;
}

sub _cute_count_no_order {
  my( $seen, $next ) = ( shift, shift );
  return $cache{$seen} if exists $cache{$seen};
  my @nos = grep { !( $seen & 1<<$_ ) } @{$next};
  return $cache{$seen} = @_
     ? sum0 map { _cute_count_no_order( $seen | 1<<$_ , @_ ) } @nos
     : scalar @nos;
}

## @_    the remaining lists of numbers to try
__END__

## Performance

The original challenge asked us to compute values up to `n=15` - the cumulative time for this is between 1.05 and 1.30 seconds. We can continue on to `n=30` taking around 19 seconds.

The script finally crashes after `n=39` (with a count of around 5.5 trillion) - when the cache memory usage exceeds 7GBytes (the capacity of the machine) and starts to swap.

| ind |             Count | Time loop  | Cumul time |
| --: | ----------------: | ---------: | ---------: |
|   1 |                 1 |   0.000010 |   0.000011 |
|   2 |                 2 |   0.000018 |   0.000076 |
|   3 |                 3 |   0.000016 |   0.000105 |
|   4 |                 8 |   0.000022 |   0.000136 |
|   5 |                10 |   0.000028 |   0.000175 |
|   6 |                36 |   0.000067 |   0.000251 |
|   7 |                41 |   0.000085 |   0.000346 |
|   8 |               132 |   0.000177 |   0.000533 |
|   9 |               250 |   0.000241 |   0.000790 |
|  10 |               700 |   0.000493 |   0.001299 |
|  11 |               750 |   0.000601 |   0.001916 |
|  12 |             4,010 |   0.001535 |   0.003466 |
|  13 |             4,237 |   0.001722 |   0.005206 |
|  14 |            10,680 |   0.002893 |   0.008116 |
|  15 |            24,679 |   0.005721 |   0.013854 |
|  16 |            87,328 |   0.009010 |   0.022884 |
|  17 |            90,478 |   0.010208 |   0.033113 |
|  18 |           435,812 |   0.020486 |   0.053620 |
|  19 |           449,586 |   0.023270 |   0.076913 |
|  20 |         1,939,684 |   0.078741 |   0.155676 |
|  21 |         3,853,278 |   0.125847 |   0.281549 |
|  22 |         8,650,900 |   0.173449 |   0.455045 |
|  23 |         8,840,110 |   0.224917 |   0.680006 |
|  24 |        60,035,322 |   0.359825 |   1.039877 |
|  25 |        80,605,209 |   0.511679 |   1.551599 |
|  26 |       177,211,024 |   0.663506 |   2.215148 |
|  27 |       368,759,752 |   1.033414 |   3.248616 |
|  28 |     1,380,348,224 |   2.533999 |   5.782659 |
|  29 |     1,401,414,640 |   2.951694 |   8.734403 |
|  30 |     8,892,787,136 |  10.241124 |  18.975582 |
|  31 |     9,014,369,784 |  11.076978 |  30.052606 |
|  32 |    33,923,638,848 |  13.505877 |  43.558524 |
|  33 |    59,455,553,072 |  20.499038 |  64.057609 |
|  34 |   126,536,289,568 |  23.903329 |  87.960986 |
|  35 |   207,587,882,368 |  57.064045 | 145.025074 |
|  36 | 1,495,526,775,088 |  99.565625 | 244.590748 |
|  37 | 1,510,769,105,288 | 109.442520 | 354.033321 |
|  38 | 3,187,980,614,208 | 134.032712 | 488.066089 |
|  39 | 5,415,462,995,568 | 175.846131 | 663.912274 |

