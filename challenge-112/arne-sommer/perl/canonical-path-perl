#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my $verbose = 0;
GetOptions("verbose" => \$verbose);

my $path = $ARGV[0] // die "Please specify the path";

die 'Path must begin with "/"' unless substr($path, 0, 1) eq '/';

my @path = split('/', $path);

shift(@path);

my @result;

for my $current (@path)
{
  say ":: current element $current" if $verbose;
  
  next unless $current;
  next if $current eq '.';

  if ($current eq '..')
  {
    pop(@result);
  }
  else
  {
    push(@result, $current);
  }
}

say '/' . join('/', @result);
