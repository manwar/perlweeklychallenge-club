#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1..3], 3 ],
  [ [2..4], 2 ],
  [ [2..4,2..4], 2 ], ## Check uniquification...
);

is( bit_sum(@{$_->[0]}), $_->[1] ) for @TESTS;
done_testing();


sub bit_sum {
  my $t = 0;                     ## Initialize sum

  my %hash = map { $_ => 1 } @_; ## quick uniquification - if worried
  @_ = keys %hash;               ## that there may be duplicates and
                                 ## question talks of unique pairs...

  while(@_>1) {                  ## Loop through array until we have
                                 ## no pairs left
    my $a = shift;               ## we shift off the value;
    $t+= $a&$_ for @_;           ## and and it with all remaining
                                 ## elements for each element in list
  }
  $t;                            ## Return sum
}
