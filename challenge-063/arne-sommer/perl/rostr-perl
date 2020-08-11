#! /usr/bin/env perl

use feature 'say';

use Getopt::Long;

my $verbose;

GetOptions ("verbose"  => \$verbose);

my $string = @ARGV[0] || 'xyxx';

die "Illegal input string" unless $string =~ /^[xy]+$/;

my $length  = length($string);
my $current = $string;

my $count = 0;

while (1)
{
  $count++;

  my $rotate = $count % $length;

  if ($rotate)
  {
    my $a = substr($current, $rotate);
    my $b = substr($current, 0, $rotate);

    $current = $a . $b;
    
    say ": Rotation $count: $current (moved '$b' to the end)" if $verbose;
  }
  elsif ($verbose)
  {
     say ": Rotation $count: $current (moved nothing)";
  }

  last if $current eq $string;
}

say "$count Rotations";
