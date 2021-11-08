#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Algorithm::Permute;
 
my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $matrix = $ARGV[0] // die "Please specify a matrix";

if ($matrix =~ /^\d+$/)
{
  my @rows;
 
  for (1 .. $matrix)
  {
    my @values = (0 .. $matrix -1);
    my $p_iterator = Algorithm::Permute->new ( \@values );
    push(@rows, join(" ", $p_iterator->next));
  }

  $matrix = join(" | ", @rows);

  say ": Matrix: $matrix";
}

my @NN;

for my $row (split(/\s*\|\s*/, $matrix))
{
  my @cols = split(/\s+/, $row);
  push(@NN, \@cols);
}

my $size = @NN;

if ($verbose)
{
  for my $from (0 .. $size -1)
  {
    for my $to (0 .. $size -1)
    {
      next if $from == $to;
      say ": Distance from city #$from to #$to: " . $NN[$from][$to];
    }
  }
}

say "" if $verbose;

my @solution;
my $solution_length = $size ** $size ** $size;
my %seen;

my @p2 = 0 .. $size -1;

my $p_iterator = Algorithm::Permute->new ( \@p2 );

PERM:
while (my @path = $p_iterator->next)
{
  my $candidate = join(" ", @path);

  my @p = @path;

  for (1 .. $size)
  {
    push(@p, shift @p);
      
    next PERM if $seen{ join(" ", @p) };
  }

  $seen{$candidate} = 1;
    
  push(@path, $path[0]);
  my @path2 = @path;

  my $from   = shift @path;
  my $length = 0;
  
  while (@path)
  {
    my $to = shift @path;
    $length += $NN[$from][$to];
    say ": " . join(" ", @path2) . " | $from -> $to = " . $NN[$from][$to] . " (sum $length)" if $verbose;
    $from = $to;
  }
  say "" if $verbose;

  if ($solution_length > $length)
  {
    $solution_length = $length;
    @solution = @path2;
  }
}

say "length = $solution_length";
say "tour = (" . join(" ", @solution) . ")";
