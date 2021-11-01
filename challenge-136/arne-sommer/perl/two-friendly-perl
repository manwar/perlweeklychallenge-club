#! /usr/bin/env perl

use strict;
use feature 'say';
use feature 'signatures';
no warnings qw(experimental::signatures);

# use List::MoreUtils 'duplicates';
use Getopt::Long;

my $verbose = 0;
GetOptions("verbose"  => \$verbose);

my $m = shift(@ARGV) // die "Please specify two integers > 0";
my $n = shift(@ARGV) // die "Please specify two integers > 0";

die "Please specify an integer > 0" unless $m =~ /^[1-9]\d*$/;
die "Please specify an integer > 0" unless $n =~ /^[1-9]\d*$/;

my $gcd    = gcd($m, $n);
my $binary = sprintf ("%b", $gcd);
my $ones   = scalar grep { /1/ } split("", $binary);

say ": GCD($m,$n): $gcd -> binary: $binary ($ones)" if $verbose;

($gcd == 1 || $ones != 1) ? say 0 : say 1;

sub gcd ($a, $b)
{
  my @a = divisors($a);
  my @b = divisors($b);
  my @common = duplicates(@a, @b);
  my $gcd    = $common[$#common];
  
  return $gcd;
}

sub divisors ($number)
{
  my @divisors = (1);
  
  for my $candidate (2 .. $number/2)
  {
    push(@divisors, $candidate) if $number % $candidate == 0;
  }
  
  push(@divisors, $number);
  
  return @divisors;
}

sub duplicates (@)
{
    my %seen = ();
    my $k;
    my $seen_undef;
    return grep { 1 < (defined $_ ? $seen{$k = $_} : $seen_undef) }
      grep { defined $_ ? not $seen{$k = $_}++ : not $seen_undef++ } @_;
}
