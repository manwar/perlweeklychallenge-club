#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use feature 'state';

use Getopt::Long;
use List::Util 'sum';

no warnings qw(experimental::signatures);

my $verbose =  0;

GetOptions("verbose" => \$verbose);

my $N       = shift(@ARGV) // 20;
my $current = 0;
my @values;

while (1)
{
  push(@values, $current) if is_fibonacci_sum($current);

  last if @values == $N;
  
  $current++;
}

say "f($N)=[" . join(", ", @values) . "]";

sub is_fibonacci_sum ($number)
{
  state %is_fibonacci = ( 0 => 1, 1 => 1 );
  state $limit = 1;
  state $fib_1 = 0;
  state $fib_2 = 1;

  my $sum = sum split(//, $number);

  say ": Considering number $number with sum $sum" if $verbose;

  return 1 if $is_fibonacci{$sum};
  
  while ($sum > $limit)
  {
    my $new   = $fib_1 + $fib_2;
    $fib_1    = $fib_2;
    $fib_2    = $new;
    $limit    = $new;

    say ": Caching Fibonacci number $limit" if $verbose;
    $is_fibonacci{$limit} = 1;
  }

  return $is_fibonacci{$sum};
}
