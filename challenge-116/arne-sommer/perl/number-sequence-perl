#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $verbose = 0;

my $N = shift(@ARGV);

die "Specify a positive integer with at least two digits"
  unless $N =~ /^[1-9]\d+$/;

my @result;

get_val(undef, $N);

sub get_val ($done, $todo)
{
  my @done = $done ? @$done : ();
  for my $size (1 .. length($todo))
  {
    my @done2 = @done;
    my $val   = substr($todo, 0, $size);
    my $todo2 = substr($todo, $size);
      
    push(@done2, $val);

    length($todo2)
      ? get_val(\@done2, $todo2)
      : push(@result, \@done2);
  }
}

for my $res (@result)
{
  if (is_consecutive(@$res))
  {
    say join(",", @$res);
    exit;
  }
}

say $N;
      
sub is_consecutive (@list)
{
  my $first = shift(@list);
  return 0 if substr($first, 0, 1) eq '0';
  my $second;

  while (@list)
  {
    $second = shift(@list);
      
    return 0 if substr($second, 0, 1) eq '0';

    return 0 unless $second == $first + 1;
    $first = $second;
  }
  return 1;
}
