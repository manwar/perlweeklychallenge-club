#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 15, 8 ],
  [ 25, 13 ],
  [ 100, 80 ],
  [ 1000, 728 ],
  [ 1100, 728 ],
  [ 1200, 728 ],
  [ 1300, 728 ],
  [ 2000, 729 ],
  [ 2100, 809 ],
  [ 2200, 810 ],
  [ 3000, 1458 ],
  [ 4000, 2187 ],
  [ 5000, 2916 ],
  [ 10000, 6560 ],
  [ 20000, 6561 ],
  [ 25000, 6561+2916 ],
  [ 25500, 6561+2916+324 ],
  [ 25540, 6561+2916+324+27 ],
  [ 25543, 6561+2916+324+27+2 ],
  [ 100000, 59048 ],
  [ 1000000, 531440  ],
);

# warn "@{$_} -> ", get_no_one_count_x($_->[0]), "\n" foreach @TESTS;

is( get_no_one_count_x($_->[0]), $_->[1] ) foreach @TESTS;
is( get_no_one_count($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

cmpthese(-5,{ 'scan 98' => sub { get_no_one_count(   98 ) },
              'opt  98' => sub { get_no_one_count_x( 98 ) }, });
cmpthese(-5,{ 'scan 987' => sub { get_no_one_count(   987 ) },
              'opt  987' => sub { get_no_one_count_x( 987 ) }, });
cmpthese(-5,{ 'scan 9876' => sub { get_no_one_count(   9876 ) },
              'opt  9876' => sub { get_no_one_count_x( 9876 ) }, });
cmpthese(-5,{ 'scan 98765' => sub { get_no_one_count(   98765 ) },
              'opt  98765' => sub { get_no_one_count_x( 98765 ) }, });
cmpthese(-5,{ 'scan 987654' => sub { get_no_one_count(   987654 ) },
              'opt  987654' => sub { get_no_one_count_x( 987654 ) }, });
cmpthese(-5,{ 'scan 9876543' => sub { get_no_one_count(   9876543 ) },
              'opt  9876543' => sub { get_no_one_count_x( 9876543 ) }, });

sub get_no_one_count {
  my $n = shift;
  return scalar grep { ! m{1} } 2..$n;
}

## Optimized version.... seems to work ... and far better than scan...
sub get_no_one_count_x {
  my ( $n, $count, $pow_9 ) = ( shift, 0, 1 );
  while($n) {
    my $t   = $n % 10; ## get last digit
    $count  = 0 if $t==1; ## Throw everything away we've found a 1
    $count += $t ? ( $t == 1 ? ($pow_9-1) : ($t-1)*$pow_9 ) : 0;
                          ## 0 it contributes nothing
                          ## 1 contributes 9^X-1
                          ## 2-9 contributes (n-1)9^X
    $pow_9 *= 9;  ## update power of nine
    $n      = ( $n - $t )/10; ## drop last digit
  }
  return $count;
}

## Comparison

# | N         | scan      | opt       | Speed-up   |
# | --------: | --------: | --------: | ---------: |
# |        98 | 16,027    | 1,173,850 |        72  |
# |       987 |  2,623    |   867,796 |       330  |
# |     9,876 |    253    |   685,956 |     2,715  |
# |    98,765 |     24.4  |   565,427 |    23,155  |
# |   987,654 |      1.23 |   482,800 |   392,998  |
# | 9,876,543 |      0.23 |   418,410 | 1,853,771  |
