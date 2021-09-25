#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use Perl6::Junction 'all';

my $verbose = 0;

GetOptions("verbose" => \$verbose);

die "Integers only" unless all(@ARGV) == qr/^\d+$/;

my @result;

my $current = shift(@ARGV) // die "No numbers";
my @current = ($current);

say ": Candidate: $current" if $verbose;

for my $i (@ARGV)
{
  if ($i > $current +1)
  {
    my @copy = @current;
    push(@result, \@copy);
    say ": Push: [", join(",", @current), "]" if $verbose;
    @current = ();
  }

  die "Not sorted ($current < $i)" unless $i > $current;
  
  say ": Candidate: $i" if $verbose;
  
  push(@current, $i);
  $current = $i;
}

push(@result, \@current) if @current;

say "(", join(", ", map { "[" . join(", ", @$_) . "]" } @result), ")";

