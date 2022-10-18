#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,2,3,2], '3 2 2' ],
  [ [1,3,2],   '' ],
  [ [1,1,2,3], '' ],
  [ [2,4,3],   '4 3 2' ],
  [ [1..10],   '10 9 8' ],
  [ [7,4,1],  '' ],
  [ [201,101,1],  '' ],
  [ [1,1,2,3,4,5,2,1,2,3,2,1,1,1,1,1], '5 4 3' ],
);

for( 1..100 ) {
  my @T = map { 1 + int rand 20 } 1 .. 3 + int rand 17;
  my $r = join ' ', (sort {$b<=>$a} @T)[0,1,2];
  push @TESTS, [ \@T, $r ]
}


is( "@{[magical(@{$_->[0]})]}", $_->[1] ) foreach @TESTS;

done_testing();

sub magical {
  @_ = sort { $b <=> $a } @_;
  while(@_>2) {
    my($a,$b,@c)=@_;
    while(@c) {
      ($b+$_>$a) ? (return $a,$b,$_ ) : last for @c;
      $b = shift @c;
    }
    shift;
  }
  ();
  #shift @max;
  #@max;
}

