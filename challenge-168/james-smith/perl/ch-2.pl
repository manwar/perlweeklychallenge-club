#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Math::Prime::Util qw(factor is_prime);

## The array is the list of home primes between 2 and 100
## {we pad the list with 0 0 so the index lines up with
## its home prime}.
##
## We skip 49 and 77 as their home prime is very large
## (and hasn't been discovered yet!) - they are the same
## number as 49 = 7x7 -> 77
##
## We are going to use the factor function of Math::Prime::Util
## which does the factoring for us - and is quick....
##
## Finally we use qw for the tests as we do a string comparison of the
## numbers - the Math::Prime::Util uses "bigint"s to store the primes,
## but unless we explicitly include a bigint library the values in the
## tests array are treated a floating point of 2^64... and so you are
## comparing different values. Keeping as a string we are comparing
## the integer string with the stringified big int.

my @TESTS = qw( 0  0
                                               2                                             3           211
                                               5                                            23             7
                             3331113965338635107                                           311           773
                                              11                                           223            13
                                           13367                                          1129      31636373
                                              17                                           233            19
                             3318308475676071413                                            37           211
                                              23                                        331319           773
                                            3251                                         13367           227
                                              29                                           547            31
                                          241271                                           311         31397
                                            1129                                         71129            37
                                             373                                           313 3314192745739
                                              41                                           379            43
                                     22815088913                                       3411949           223
                                              47                        6161791591356884791277             0
                                            3517                                           317          2213
                                              53                                          2333           773
                                           37463                                          1129           229
                                              59                                         35149            61
                                           31237                                           337 1272505013723
              1381321118321175157763339900357651                                          2311            67
                                            3739                                         33191           257
                                              71                                       1119179            73
                                             379                                           571        333271
                                               0                                    3129706267            79
313169138727147145210044974146858220729781791489                               193089459713411           241
                                              83                                          2237          3137
                       6012903280474189529884459                    41431881512748629379008933        719167
                                              89                                         71171     236122171
                                          331319                                           331          1319
                                           36389 172929671097972226356946608292031596899264419            97
                                             277                                         71143        317047
);

## Skip 1 (no prime factors), 49, 77 (large value for home prim)
is( home_prime($_), $TESTS[$_] ) for 2..48,50..76,78..100;

done_testing();

say sprintf '%4d: %64s',$_, $_==49 || $_ == 77 ? "***": th(home_prime($_)) for 2..100;

sub home_prime {
  return if (my$t=shift)<2;  ## Skip in t is 0 or 1 which would loop infinitely...
  is_prime($t)?(return$t):($t=join'',factor$t)while 1; ## If prime we return o/w we compute sum of factors
}

sub th {
  my $t = reverse $_[0];
  $t =~ s{(\d{3})}{$1,}g;
  $t = reverse $t;
  $t =~ s{^,}{};
  $t;
}
