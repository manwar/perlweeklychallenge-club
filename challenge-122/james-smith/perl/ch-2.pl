#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Time::HiRes qw(time);

## Pre-populate cache with first 3 values...
my %cache = (
 1 => [qw(1)],
 2 => [qw(11 2)],
 3 => [qw(111 12 21 3)],
);

my %methods = qw(
  cache  pts_non_streaming
  str    pts_streaming
  opt    pts_streaming_opt
);

my($start,$calls) = (time,0);
my $method = @ARGV ? shift @ARGV : 'opt';
$method = $methods{ $method } || $methods{ 'opt' };
my $total  = @ARGV ? $ARGV[0] : 10;


sub pts_non_streaming {
  say join "\n", @{pts(shift)};
}

sub pts {
  $calls++;
  ## Let's look at the first points scored - it is either
  ## 1, 2 or 3.
  ## So we then look to see how remaining points are scored
  ## these are 1 - followed by all combinations for n-1
  ##           2 - followed by all combinations for n-2
  ##           3 - followed by all combinations for n-3
  ## The special cases are therefore where any of these values
  ## are less than 1 - so we need to have pre-populated values
  ## for 1, 2 and 3 points (1; 11+2; 111+12+21+3 respectively)
  ## We cache values as we know that we will see certain
  ## values occuring repeatedly {e.g. the start sequences
  ## 111, 12, 21 3 all then get all sequences for n-3
  return $cache{$_[0]} ||= $_[0] < 1 ? [] : [
     map( {'1'.$_} @{pts( $_[0]-1 )} ),
     map( {'2'.$_} @{pts( $_[0]-2 )} ),
     map( {'3'.$_} @{pts( $_[0]-3 )} )
  ];
}

sub pts_streaming {
  $calls++;
  ## 2nd approach - minimial memory...
  ## This approach does no cachine and does not store large
  ## arrays of data - instead of collecting the array of
  ## results from each stage and then adding to them as we
  ## go up we instead record the path we are traversing until
  ## we get to a score of 0.
  ##
  return if  $_[0]<0;
  return say $_[1] unless $_[0];
  pts_streaming( $_[0]-$_, $_[1].$_ ) foreach 1..3;
}

sub pts_streaming_opt {
  $calls++;
  ## 2nd approach - minimial memory...
  ## This approach does no cachine and does not store large
  ## arrays of data - instead of collecting the array of
  ## results from each stage and then adding to them as we
  ## go up we instead record the path we are traversing until
  ## we get to a score of 0.
  ##
  ## We short cut the last 3 stages when number of pts < 4
  ## this avoids unneccesary recursive calls which result in
  ## empty results - or calling only to output what is passed
  ## (we know that function call overheads are relatively
  ## high in recursive code)
  return say "$_[1]1"                             if $_[0] == 1; ## Three special cases
  return say "$_[1]11\n$_[1]2"                    if $_[0] == 2; ## when we have  1, 2,
  return say "$_[1]111\n$_[1]12\n$_[1]21\n$_[1]3" if $_[0] == 3; ## or 3 points to go.
  pts_streaming_opt( $_[0]-$_, $_[1].$_ ) foreach 1..3;
}

## Execute the chosen method - and report size time and method calls.
&{\&{$method}}( $total,'' );
my $size = `ps -p $$ -h -o size` =~ s/\s+//rg;
warn sprintf "%-20s %3d %12d %12d %12.6f\n", $method, $total, $calls, $size, time-$start;

