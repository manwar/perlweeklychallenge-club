#! /usr/bin/env perl

use strict;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

my $verbose = 0;

if (@ARGV && $ARGV[0] eq "--verbose")
{
  $verbose = 1;
  shift(@ARGV);
}

my $N = shift(@ARGV) // 3;

die '$N out of range (2..5)' unless 2 <= $N && $N <=5;

my @sequence = (0,1,3,2);

for my $level (3 .. $N)
{
  @sequence = generate2bgcs($level, $verbose, @sequence);
}

say "[" . join(", ", @sequence) . "]";

sub generate2bgcs ($level, $verbose, @in)
{
  my @S1a = map { sprintf('%0' . ($level-1)  . 'b', $_) } @in;
  my @S2a = reverse @S1a;
  my @S1  = map { "0$_" } @S1a;
  my @S2  = map { "1$_" } @S2a;
  my @S3  = (@S1, @S2); 
  my @out = map { oct("0b$_") } @S3;
  
  if ($verbose)
  {
    say ": a) S1 = [" . join(", ", @S1a) ."]";
    say ": b) S2 = [" . join(", ", @S2a) ."]";
    say ": c) S1 = [" . join(", ", @S1)  ."]";
    say ": b) S2 = [" . join(", ", @S2)  ."]";
    say ": e) S3 = [" . join(", ", @S3)  ."]";
    say ": \$N=$level  = [" . join(", ", @out) . "]";
  }
  return @out;
}
