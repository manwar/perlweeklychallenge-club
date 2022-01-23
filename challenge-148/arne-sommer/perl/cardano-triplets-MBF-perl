#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

use Getopt::Long;
use Math::BigFloat;

no warnings qw(experimental::signatures);

my $verbose =  0;
my $limit   = 21;
my $count   =  5;

GetOptions("limit" => \$limit, "count" => \$count, "verbose" => \$verbose);

for my $a (1 .. $limit)
{
  for my $b (1 .. $limit)
  {
    for my $c (1 .. $limit)
    {
      my $left  = Math::BigFloat->new($a);
      my $right = Math::BigFloat->new($a);

      my $c_sqrt = Math::BigFloat->new($c)->bsqrt;
     
      $left->badd(Math::BigFloat->new($b)->bmul($c_sqrt));
      $right->bsub(Math::BigFloat->new($b)->bmul($c_sqrt));

      say ": Considering $a, $b, $c" if $verbose;

      # say "$a|$b|$c|L:$left (" . cube_root($left) . ")|R:$right(" . cube_root($right) . ")" . " " .cube_root($left)->badd(cube_root($right));

      my $sum = cube_root($left)->badd(cube_root($right));
      if ($sum->beq(1))
      {
        say "($a, $b, $c)";
	exit if $count-- == 1; 
      }
    }
  }
}

sub cube_root ($number)
{
  my $third = Math::BigFloat->new(1)->bdiv(3);
  return $number->bpow($third) unless $number->is_negative; # include zero.
  return $number->babs()->bpow($third)->bneg();
}
