#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use Perl6::Junction 'all';
use List::Util qw(sum);
use feature 'signatures';

no warnings qw(experimental::signatures);

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my @values = @ARGV;

die "Please specify a list of positve integers" unless @values;
die "Integers only" unless qr/^[1-9][0-9]*$/ == all(@values);

while (@values > 1)
{
  say ": @values" if $verbose;

  @values = next_row(@values);
}

say $values[0];

sub next_row (@values)
{
  my @new;
  
  for my $index (1 .. @values -1)
  {
    push(@new, sum(@values[1..$index]));
  }
  return @new;
}
