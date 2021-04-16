#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $ANSWER_10 = '1 1 2 5 15 52 203 877 4140 21147';
my $ANSWER_20 = '1 1 2 5 15 52 203 877 4140 21147 115975 678570 4213597 27644437 190899322 1382958545 10480142147 82864869804 682076806159 5832742205057';

is( "@{ bell_numbers(10) }", $ANSWER_10 );
is( "@{ bell_numbers(20) }", $ANSWER_20 );

done_testing();

sub bell_numbers {
  my $N = shift;
  my @res = my @a = 1;
  while(1) {
    push @res, my @b = $a[-1];
    return \@res if @res >= $N;
    push @b, $b[-1] + $_ foreach @a;
    @a = @b;
  }
}


